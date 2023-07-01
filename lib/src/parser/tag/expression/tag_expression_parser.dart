import 'package:petitparser/petitparser.dart';
import 'package:template_engine/template_engine.dart';

class ExpressionTag extends Tag {
  ExpressionTag()
      : super(
            name: 'ExpressionTag',
            description: 'Evaluates an expression that can contain values '
                '(bool, num, string), operators, functions, constants '
                'and variables');

  @override
  Parser<Object> createTagParser(ParserContext context) =>
      (string(context.tagStart) &
              expressionParser(context) &
              string(context.tagEnd))
          .map2((values, parsePosition) => ExpressionRender(
              source: TemplateSource(
                template: context.template,
                parserPosition: parsePosition,
              ),
              expression: values[1]));
}

class ExpressionRender implements Renderer {
  final Expression expression;
  final TemplateSource source;
  ExpressionRender({required this.source, required this.expression});

  @override
  render(RenderContext context) => expression.eval(context.variables);
}
