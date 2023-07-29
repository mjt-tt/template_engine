import 'package:template_engine/src/template.dart';
import 'package:template_engine/src/template_engine.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  test('"The cos of 2 pi = {{cos(2 * pi)}}." should render : 1', () {
    var engine = TemplateEngine();
    const template = TextTemplate('The cos of 2 pi = {{cos(2 * pi)}}.');
    var parseResult = engine.parse(template);
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('The cos of 2 pi = 1.0.');
  });

  test('"" should render ', () {
    var engine = TemplateEngine();
    const template = TextTemplate('The volume of a sphere = '
        '{{ round( (3/4) * pi * (radius ^ 3) )}}.');
    var parseResult = engine.parse(template);
    var renderResult = engine.render(parseResult, {'radius': 10});
    renderResult.text.should.be('The volume of a sphere = 2356.');
  });
}
