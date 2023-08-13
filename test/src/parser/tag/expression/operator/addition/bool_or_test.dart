import 'package:shouldly/shouldly.dart';
import 'package:template_engine/template_engine.dart';
import 'package:test/test.dart';

void main() {
  test('{{false|false}} should render: false', () {
    var engine = TemplateEngine();
    var parseResult = engine.parse(const TextTemplate('{{false|false}}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('false');
  });
  test('{{false|true}} should render: true', () {
    var engine = TemplateEngine();
    var parseResult = engine.parse(const TextTemplate('{{false|true}}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('true');
  });
  test('{{true|false}} should render: true', () {
    var engine = TemplateEngine();
    var parseResult = engine.parse(const TextTemplate('{{true|false}}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('true');
  });
  test('{{true|true}} should render: true', () {
    var engine = TemplateEngine();
    var parseResult = engine.parse(const TextTemplate('{{true|true}}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('true');
  });

  test('{{false | FALSE | falsE}} should render: false', () {
    var engine = TemplateEngine();
    var parseResult =
        engine.parse(const TextTemplate('{{false | FALSE | falsE}}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('false');
  });
  test('{{ true | FALSE | truE }} should render: true', () {
    var engine = TemplateEngine();
    var parseResult =
        engine.parse(const TextTemplate('{{ true | FALSE | truE }}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('true');
  });
  test('{{"text"|"text"}} should result in an error', () {
    var engine = TemplateEngine();
    var parseResult = engine.parse(const TextTemplate('{{"text"|"text"}}'));
    var renderResult = engine.render(parseResult);
    //renderResult.text.should.be('{{ERROR}}');
    renderResult.errorMessage.should
        .be('Render Error: left and right of the | operator must be a boolean, '
            'position: 1:9, source: Text');
  });
}
