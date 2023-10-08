import 'dart:math';

import 'package:shouldly/shouldly.dart';
import 'package:template_engine/template_engine.dart';
import 'package:test/test.dart';

void main() {
  test('{{log(7)}} should render as: ${log(7).toString()}', () {
    var engine = TemplateEngine();
    var parseResult = engine.parseTemplate(TextTemplate('{{log(7)}}'));
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be(log(7).toString());
  });
}
