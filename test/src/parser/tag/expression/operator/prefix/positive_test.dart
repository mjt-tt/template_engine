import 'package:shouldly/shouldly.dart';
import 'package:template_engine/template_engine.dart';
import 'package:test/test.dart';

void main() {
  test('{{+3}} should render: 3', () {
    var engine = TemplateEngine();
    var parseResult = engine.parse(const TextTemplate('{{+3}}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('3');
  });

  test('{{+"text"}} should throw in an error', () {
    var engine = TemplateEngine();
    var parseResult = engine.parse(const TextTemplate('{{+"text"}}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('{{ERROR}}');
    renderResult.errorMessage.should
        .be('Render Error: number expected after the + operator, '
            'position: 1:3, source: Text');
  });
}
