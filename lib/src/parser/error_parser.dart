import 'package:petitparser/petitparser.dart';
import 'package:template_engine/template_engine.dart';

/// This [Parser] looks for any remaining tags that where not recognized
/// by the [Tag][Parser]s.
/// It will return this unknown tag as a [String] and add detailed error(s)
/// to the [ParserContext].
class InvalidTagParser extends Parser<Object> {
  final ParserContext parserContext;
  final Parser<String> tagStartParser;
  final Parser<String> anythingBeforeEndParser;
  final Parser<String> tagEndParser;
  InvalidTagParser(this.parserContext)
      : tagStartParser = string(parserContext.tagStart),
        anythingBeforeEndParser =
            untilEndOfTagParser(parserContext.tagStart, parserContext.tagEnd),
        tagEndParser = string(parserContext.tagEnd);

  @override
  Parser<Object> copy() => InvalidTagParser(parserContext);

  /// see dart doc if this class.
  @override
  Result<Object> parseOn(Context context) {
    var errors = <Error>[];
    var tagStartResult = tagStartParser.parseOn(context);
    if (tagStartResult.isFailure) {
      return tagStartResult;
    }
    var expressionResult = expressionParser(parserContext, verboseErrors: true)
        .parseOn(tagStartResult);
    if (expressionResult.position > tagStartResult.position) {
      if (expressionResult.isFailure) {
        errors.add(Error.fromFailure(
          stage: ErrorStage.parse,
          failure: expressionResult as Failure,
          template: parserContext.template,
        ));
      }
    }

    var anythingBeforeEndResult =
        anythingBeforeEndParser.parseOn(expressionResult);
    if (errors.isEmpty &&
        anythingBeforeEndResult.isSuccess &&
        anythingBeforeEndResult.value.isNotEmpty) {
      errors.add(Error.fromContext(
        stage: ErrorStage.parse,
        message: 'invalid tag syntax',
        context: expressionResult,
        template: parserContext.template,
      ));
    }

    var tagEndResult = tagEndParser.parseOn(anythingBeforeEndResult);
    if (tagEndResult.isFailure) {
      return tagEndResult;
    }

    if (errors.isNotEmpty) {
      parserContext.errors.addAll(errors);
      String tag =
          context.buffer.substring(context.position, tagEndResult.position);
      return tagEndResult.success(tag);
    } else {
      return tagEndResult.failure('not an invalid tag');
    }
  }
}

/// Adds an error if a [Tag] end is found but not a  [Tag] start.
/// It replaces the [Tag] end to a [String] e.g. containing: }}
Parser<String> missingTagStartParser(ParserContext parserContext) =>
    string(parserContext.tagEnd).map2((value, context) {
      parserContext.errors.add(Error.fromContext(
          stage: ErrorStage.parse,
          context: context,
          message: 'Found tag end: ${parserContext.tagEnd}, '
              'but it was not preceded with a tag start: ${parserContext.tagStart}',
          template: parserContext.template));
      return value;
    });

// Adds an error if a [Tag] start is found but no [Tag] start because if
/// they are both present they would have been parsed already.
/// It replaces the [Tag] end to a [String] e.g. containing: {{
Parser<String> missingTagEndParser(ParserContext parserContext) =>
    (string(parserContext.tagStart) &
            any().star() &
            string(parserContext.tagEnd).not())
        .map2((values, context) {
      parserContext.errors.add(Error.fromContext(
          stage: ErrorStage.parse,
          context: context,
          message: 'Found tag start: ${parserContext.tagStart}, '
              'but it was not followed with a tag end: ${parserContext.tagEnd}',
          template: parserContext.template));
      return values.first;
    });
