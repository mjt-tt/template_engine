import 'package:template_engine/template_engine.dart';

/// Renders some value depending on the implementation of the [Renderer]
///
/// For [T] see [RenderType]
///

abstract class Renderer<T> {
  T render(RenderContext context);
}

class RenderException implements Exception {
  final Error error;
  RenderException(this.error);
}

/// Types returned by the [Renderer.render] method or
/// the Type of [ParserTree.nodes] are normally one of the following:
/// * String
/// * int
/// * double
/// * bool
/// * DateTime
/// * Some other object
/// * [Renderer]<Generic type is on of the above>
/// * List<Generic type is on of the above>
abstract class RenderType {
  /// Documentation only
}

/// The [ParserTree](https://en.wikipedia.org/wiki/Parse_tree) contains
/// parsed nodes that can be rendered to a [String].
class ParserTree extends Renderer<String> {
  /// The nodes that where parsed and can be rendered to a [String].
  /// The nodes are of type [RenderType]
  List<Object> nodes;

  ParserTree([this.nodes = const []]);

  @override
  String render(RenderContext context) =>
      nodes.map((node) => renderNode(context, node)).join();

  String renderNode(RenderContext context, Object node) {
    if (node is Renderer) {
      try {
        return node.render(context).toString();
      } on Exception catch (e) {
        if (e is RenderException) {
          context.errors.add(e.error);
        }
        return context.renderAsError;
      }
    } else if (node is List) {
      return node.map((n) => renderNode(context, n)).join();
    } else {}
    return node.toString();
  }
}

class RenderContext {
  final TemplateEngine engine;
  final Variables variables;
  final List<Error> errors;
  final String renderAsError;
  RenderContext(this.engine, {String? renderAsError, Variables? variables})
      : variables = variables ?? {},
        renderAsError =
            renderAsError ?? '${engine.tagStart}ERROR${engine.tagEnd}',
        errors = [];
}

class RenderResult {
  final List<Error> errors;
  final String text;

  RenderResult({
    required this.text,
    this.errors = const [],
  });

  String get errorMessage => errors.map((error) => error.toString()).join('\n');

  @override
  String toString() => text;
}
