import 'package:shouldly/shouldly.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:template_engine/src/error.dart';
import 'package:template_engine/src/render.dart';
import 'package:template_engine/src/template.dart';
import 'package:template_engine/src/variable/variable_renderer.dart';

void main() {
  given('objects: Variables', () {
    var variables = {
      'person': {
        'name': 'John Doe',
        'age': 30,
        'child': {
          'name': 'Jane Doe',
          'age': 5,
        }
      }
    };

    given(
        'objects: ParseContext and '
        'VariableNode with variable name "person"', () {
      var node = VariableNode(
        source: DummyTemplateSection(),
        namePath: 'person',
      );
      var context = RenderContext(variables);

      when('call: node.render(context)', () {
        var result = node.render(context);

        then('expect: context.errors to be empty',
            () => context.errors.should.beEmpty());

        then(
            'expect: result should be '
            '"{name: John Doe, age: 30, child: {name: Jane Doe, age: 5}}"',
            () => result.should.be(
                '{name: John Doe, age: 30, child: {name: Jane Doe, age: 5}}'));
      });
    });

    given(
        'objects: ParseContext and '
        'VariableNode with variable name "person.name"', () {
      var node = VariableNode(
        source: DummyTemplateSection(),
        namePath: 'person.name',
      );
      var context = RenderContext(variables);

      when('call: node.render(context)', () {
        var result = node.render(context);
        then('expect: context.errors to be empty',
            () => context.errors.should.beEmpty());

        then('expect: result should be "John Doe"',
            () => result.should.be('John Doe'));
      });
    });

    given(
        'objects: ParseContext and '
        'VariableNode with variable name "person.name.child.name"', () {
      var node = VariableNode(
        source: DummyTemplateSection(),
        namePath: 'person.child.name',
      );
      var context = RenderContext(variables);

      when('call: node.render(context)', () {
        var result = node.render(context);
        then('expect: context.errors to be empty',
            () => context.errors.should.beEmpty());

        then('expect: result should be "Jane Doe"',
            () => result.should.be('Jane Doe'));
      });
    });

    /// none existing variable name

    given(
        'objects: ParseContext and '
        'VariableNode with none existing variable name', () {
      var node = VariableNode(
        source: DummyTemplateSection(),
        namePath: 'invalid',
      );
      var context = RenderContext(variables);

      when('call: node.render(context)', () {
        var result = node.render(context);

        then('expect: empty result', () => result.should.be(''));

        then('expect: context.errors to contain 1 error',
            () => context.errors.length.should.be(1));

        then('expect: context.errors[0].stage == errorStage.render',
            () => context.errors[0].stage.should.be(ErrorStage.render));

        then(
            'expect: context.errors[0].severity == errorSeverity.error',
            () => context.errors[0].message.should
                .be('Variable name path could not be found: invalid'));

        then(
            'expect: context.errors[0].source == "position: 1:4 source: Text"',
            () => context.errors[0].source
                .toString()
                .should
                .be('position: 1:4 source: Text'));

        then(
          'expect: context.errors[0].occurrence == no older than 1 minute',
          () => context.errors[0].occurrence.should
              .beCloseTo(DateTime.now(), delta: const Duration(minutes: 1)),
        );

        then(
          'expect: context.errors[0].toString is correct',
          () => context.errors[0]
              .toString()
              .should
              .be('Render Error: Variable name path could not be found: '
                  'invalid position: 1:4 source: Text'),
        );
      });
    });
  });
}

class DummyTemplateSection extends ErrorSource {
  DummyTemplateSection()
      : super(template: TextTemplate('Hello {{name}}.'), parserPosition: '1:4');
}
