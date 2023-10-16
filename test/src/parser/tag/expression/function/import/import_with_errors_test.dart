import 'dart:math';

import 'package:shouldly/shouldly.dart';
import 'package:template_engine/template_engine.dart';
import 'package:test/test.dart';

void main() {
//TODO parse errors of imported templates
//TODO imported templates that do not exist or could not be read

  test('Test parse and render errors in imported template', () {
    var engine = TemplateEngine();
    var templatePath = ProjectFilePath(
        'test/src/parser/tag/expression/function/import/import_with_errors1.md.template');
    var template = FileTemplate.fromProjectFilePath(templatePath);
    var parseResult = engine.parseTemplate(template);
    var renderResult = engine.render(parseResult);
    const expectedError =
        'Errors in: test/src/parser/tag/expression/function/import/import_with_errors1.md.template:\n'
        '  Parse error:\n'
        '    3:35: Found tag end: }}, but it was not preceded with a tag start: {{\n'
        '  Render errors:\n'
        '    2:3: Errors while importing test/src/parser/tag/expression/function/import/import_with_errors2.md.template:\n'
        '      2:3: Error while importing test/src/parser/tag/expression/function/import/import_with_errors3.md.template:\n'
        '        2:12: Variable does not exist: name\n'
        '      3:12: Variable does not exist: name\n'
        '    3:12: Variable does not exist: name';
    renderResult.errorMessage.should.be(expectedError);

    const expectedText = '{{ERROR}}\r\n'
        '{{ERROR}}\r\n'
        '{{ERROR}}\r\n'
        '3: Hello {{ERROR}}. This is wrong: }}\r\n'
        '2: Hello {{ERROR}}. This is wrong: }}\r\n'
        '1: Hello {{ERROR}}. This is wrong: }}';
    renderResult.text.should.be(expectedText);
  });
}

stringCompare(String s1, String s2) {
  if (s1 == s2) {
    return 'equal';
  } else {
    int index = 0;
    int line = 1;
    int column = 1;
    int length = min(s1.length, s2.length);
    do {
      if (s1.codeUnitAt(index) != s2.codeUnitAt(index)) {
        return 'Different characters (${s1.codeUnitAt(index)} versus ${s2.codeUnitAt(index)}) at index: $index, line: $line, column: $column';
      } else if (s1.codeUnitAt(index) == 13) {
        line++;
        column = 1;
      }
      index++;
      column++;
    } while (index < length);
    if (s1.length > s2.length) {
      return 's1 has more charters, starting with character: ${s1.codeUnitAt(index)} at index: $index, line: $line, column: $column';
    } else {
      return 's2 has more charters, starting with character: ${s2.codeUnitAt(index)} at index: $index, line: $line, column: $column';
    }
  }
}
