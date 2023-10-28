import 'dart:convert';
import 'dart:io';

import 'package:shouldly/shouldly.dart';
import 'package:template_engine/template_engine.dart';
import 'package:test/test.dart';

void main() async {
  test('test Http template', () async {
    const url =
        "https://raw.githubusercontent.com/domain-centric/template_engine/"
        "main/doc/template/common/generated_comment.template";
    String text = await fetchUrlBodyAsString(url);
    var template = HttpTemplate(source: url.toString(), text: text);
    var engine = TemplateEngine();
    var parseResult = engine.parseTemplate(template);
    var renderResult = engine.render(parseResult);
    renderResult.text.should.be('[//]: # (This document was generated by '
        'template_engine/tool/generate_documentation.dart from '
        'https://raw.githubusercontent.com/domain-centric/template_engine/main'
        '/doc/template/common/generated_comment.template)');
  });
}

class HttpTemplate extends Template {
  HttpTemplate({required super.source, required super.text});
}

Future<String> fetchUrlBodyAsString(String url) async {
  var request = await HttpClient().getUrl(Uri.parse(url));
  var response = await request.close();
  return response.transform(const Utf8Decoder()).join();
}
