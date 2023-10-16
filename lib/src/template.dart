import 'dart:io';

import 'package:template_engine/template_engine.dart';

/// A template is a text that can contain [Tag]s.
/// This text is parsed by the [TemplateEngine] into [Renderer]s.
/// These [Renderer]s render a new text.
/// [TagRenderer]s are replaced with some other text, depending on the
/// implementation of the [TagRenderer]
abstract class Template {
  /// Explains where the template text came form.
  final String source;

  /// The text to be parsed by the [TemplateEngine]
  final String text;

  const Template({
    required this.source,
    required this.text,
  });

  @override
  bool operator ==(Object other) =>
      other is Template &&
      other.source.toLowerCase() == source.toLowerCase() &&
      other.text == text;

  @override
  int get hashCode => source.toLowerCase().hashCode ^ text.hashCode;
}

class TextTemplate extends Template {
  TextTemplate(String text)
      : super(
          source: createSource(text),
          text: text,
        );

  static createSource(String text) {
    String textToShow = text.split(RegExp('\\n')).first;

    if (textToShow.length > 40) {
      textToShow = textToShow.substring(0, 40);
    }

    if (text.length > textToShow.length) {
      return "'$textToShow...'";
    } else {
      return "'$textToShow'";
    }
  }
}

class FileTemplate extends Template {
  FileTemplate(File source)
      : super(source: source.path, text: source.readAsStringSync());

  FileTemplate.fromProjectFilePath(ProjectFilePath path)
      : super(source: path.relativePath, text: path.file.readAsStringSync());
}

//TODO WebTemplate: gets text from a URL

class ImportedTemplate extends FileTemplate {
  ImportedTemplate.fromProjectFilePath(super.path)
      : super.fromProjectFilePath();
}
