import 'package:shouldly/shouldly.dart';
import 'package:template_engine/template_engine.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('test: true', () {
    test('{{true}} should be rendered as true', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{true}}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('true');
    });

    test('{{TRUE}} should be rendered as true', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{TRUE}}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('true');
    });

    test('{{   TRue}} should be rendered as true', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{   TRue}}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('true');
    });

    test('{{trUE  }} should be rendered as true', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{trUE   }}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('true');
    });

    test('{{  true  }} should be rendered as true', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{  true  }}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('true');
    });
  });
  group('test: false', () {
    test('{{false}} should be rendered as false', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{false}}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('false');
    });

    test('{{FALSE}} should be rendered as false', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{FALSE}}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('false');
    });

    test('{{   FAlse}} should be rendered as false', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{   FAlse}}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('false');
    });

    test('{{faLSE  }} should be rendered as false', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{faLSE   }}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('false');
    });

    test('{{  false  }} should be rendered as false', () {
      var engine = TemplateEngine();
      var parserResult = engine.parseTemplate(TextTemplate('{{  false  }}'));
      var renderResult = engine.render(parserResult);
      renderResult.text.should.be('false');
    });
  });
}
