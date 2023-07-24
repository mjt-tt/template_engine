[//]: # (This document was generated by template_engine/tool/generate_documentation.dart using template_engine/doc/template/README.md.template)
[![Pub Package](https://img.shields.io/pub/v/template_engine)](https://pub.dev/packages/template_engine)
[![Code Repository](https://img.shields.io/badge/repository-git%20hub-informational)](https://github.com/domain-centric/template_engine)
[![GitHub Stars](https://img.shields.io/github/stars/domain-centric/template_engine)](https://github.com/domain-centric/template_engine/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/domain-centric/template_engine)](https://github.com/domain-centric/template_engine/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/domain-centric/template_engine)](https://github.com/domain-centric/template_engine/pulls)
[![GitHub License](https://img.shields.io/badge/license-MIT-informational)](https://github.com/domain-centric/template_engine/blob/main/LICENSE)

![](https://raw.githubusercontent.com/domain-centric/template_engine/main/doc/template/template_engine.png)

# template_engine
A flexible Dart library to parse templates and render output such as:
* [Html](https://en.wikipedia.org/wiki/HTML)
* [Programming code](https://en.wikipedia.org/wiki/Programming_language)
* [Markdown](https://en.wikipedia.org/wiki/Markdown)
* [Xml](https://en.wikipedia.org/wiki/XML), [Json](https://en.wikipedia.org/wiki/JSON), [Yaml](https://en.wikipedia.org/wiki/YAML)
* Etc...

# Features
* You can use expression containing:
  * Base types
  * Constants
  * Variables
  * Operators
  * Functions
* All of the above can be customized or you could add your own.

# Getting started

See: [Installing](https://pub.dev/packages/template_engine/install)

# Examples

```dart
import 'package:template_engine/template_engine.dart';

void main() {
  var template = TextTemplate('Hello name.');
  // See also FileTemplate and WebTemplate
  var engine = TemplateEngine();
  var parseResult = engine.parse(template, {'name': 'world'});
  // Here you could additionally mutate or validate the parseResult if needed.
  print(engine.render(parseResult)); // should print 'Hello world.';
}
```

Note the documentation of the template_engine package was generated by itself.
See: [tool/generate_documentation.dart](https://github.com/domain-centric/template_engine/blob/main/tool/generate_documentation.dart)

For more see: [Examples](https://pub.dev/packages/template_engine/example)

# Tags
[//]: # (TODO: This text should be imported from the dart doc of the Tag class using document_generator package)
Tags are specific texts in templates that are replaced by the
TemplateEngine with other information.

A tag:
* Starts with some bracket and/or character combination, e.g.: {{
* Followed by some contents
* Ends with some closing bracket and/or character combination, e.g.: }}

A tag example: {{customer.name}}

By default the TemplateEngine tags start with {{ and end with }} brackets,
just like the popular template engines [Mustache](http://mustache.github.io/) 
and [Handlebars](https://handlebarsjs.com).

You can also define alternative tag brackets in the TemplateEngine constructor
parameters. See TemplateEngine.tagStart and TemplateEngine.tagEnd.

It is recommended to use a start and end combination that is not used
elsewhere in your templates, e.g.: Do not use < > as tag start and end
if your template contains HTML or XML.

The TemplateEngine comes with default tags. You can replace or add your
own tags by manipulating the the TemplateEngine.tags field.

## ExpressionTag
Evaluates an expression that can contain values (bool, num, string), operators, functions, constants and variables.
Example: The cos of 2 pi = {{cos(2 * pi)}}. The volume of a sphere = {{ (3/4) * pi * (radius ^ 3) }}.

# Base types in tag expressions
<table>
<tr><th colspan="2">String</th></tr>
<tr><td>description:</td><td>a form of data containing a sequence of characters</td></tr>
<tr><td>examples:</td><td>'Hello'<br>
"world"<br>
'Hel'+'lo '&"world" & "."</td></tr>
</table>

<table>
<tr><th colspan="2">Number</th></tr>
<tr><td>description:</td><td>a form of data to express the size of something.</td></tr>
<tr><td>examples:</td><td>42<br>
-123<br>
3.141<br>
1.2e5<br>
3.4e-1</td></tr>
</table>

<table>
<tr><th colspan="2">Boolean</th></tr>
<tr><td>description:</td><td>a form of data with only two possible values :"true" and "false"</td></tr>
<tr><td>examples:</td><td>true<br>
TRUE<br>
TRue<br>
false<br>
FALSE<br>
FAlse</td></tr>
</table>


# Variables in tag expressions
[//]: # (TODO: This text should be imported from the dart doc of the Variable class using document_generator package)
A [Variable](https://en.wikipedia.org/wiki/Variable_(computer_science)) is
a named container for some type of information 
(like number, boolean, String etc...)
 
[//]: # (TODO: This text should be imported from the dart doc of the Variables typedef using document_generator package)
* Variables are stored as key, value pairs in a dart Map<String, Object> where:
  * String=Variable name
  * Object=Variable value
* Variables can be used in a tag expression
* Initial variable values are passed to the TemplateEngine.render method
* Variables can be modified during rendering 

[//]: # (TODO: This text should be imported from the dart doc of the VariableName class using document_generator package)
The variable name:
* must be unique and does not match a other [Tag] syntax
* must start with a letter, optionally followed by letters and or digits
* is case sensitive (convention: use [camelCase](https://en.wikipedia.org/wiki/Camel_case))

Variables can be nested. Concatenate variable names separated with dot's
to get the variable value of a nested variable.

E.g.:<br>
Variable map: {'person': {'name': 'John Doe', 'age',30}}<br>
Variable Name person.name: refers to the variable value of 'John Doe'
 
Examples:
* [Variable Example](https://github.com/domain-centric/template_engine/blob/main/example/tag_variable_simple.dart)
* [Nested Variable Example](https://github.com/domain-centric/template_engine/blob/main/example/tag_variable_nested.dart)

# Functions in tag expressions
## Math Functions
<table>
<tr><th colspan="5">exp</th></tr>
<tr><td>description:</td><td colspan="4">Returns the natural exponent e, to the power of the value</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{exp(7)}}</td></tr>
<tr><td>example result:</td><td colspan="4">1096.6331584284585</td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">log</th></tr>
<tr><td>description:</td><td colspan="4">Returns the natural logarithm of the value</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{log(7)}}</td></tr>
<tr><td>example result:</td><td colspan="4">1.9459101490553132</td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">sin</th></tr>
<tr><td>description:</td><td colspan="4">Returns the sine of the radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{sin(7)}}</td></tr>
<tr><td>example result:</td><td colspan="4">0.6569865987187891</td></tr>
<tr><td>parameter:</td><td>radians</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">asin</th></tr>
<tr><td>description:</td><td colspan="4">Returns the values arc sine in radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{asin(0.5)}}</td></tr>
<tr><td>example result:</td><td colspan="4">0.5235987755982989</td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">cos</th></tr>
<tr><td>description:</td><td colspan="4">Returns the cosine of the radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{cos(7)}}</td></tr>
<tr><td>example result:</td><td colspan="4">0.7539022543433046</td></tr>
<tr><td>parameter:</td><td>radians</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">acos</th></tr>
<tr><td>description:</td><td colspan="4">Returns the values arc cosine in radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{acos(0.5)}}</td></tr>
<tr><td>example result:</td><td colspan="4">1.0471975511965979</td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">tan</th></tr>
<tr><td>description:</td><td colspan="4">Returns the the tangent of the radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{tan(7)}}</td></tr>
<tr><td>example result:</td><td colspan="4">0.8714479827243188</td></tr>
<tr><td>parameter:</td><td>radians</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">atan</th></tr>
<tr><td>description:</td><td colspan="4">Returns the values arc tangent in radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{atan(0.5)}}</td></tr>
<tr><td>example result:</td><td colspan="4">0.4636476090008061</td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">sqrt</th></tr>
<tr><td>description:</td><td colspan="4">Returns the positive square root of the value.</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{sqrt(9)}}</td></tr>
<tr><td>example result:</td><td colspan="4">3.0</td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

## String Functions
<table>
<tr><th colspan="5">length</th></tr>
<tr><td>description:</td><td colspan="4">Returns the length of a string</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>example:</td><td colspan="4">{{length("Hello")}}</td></tr>
<tr><td>example result:</td><td colspan="4">5</td></tr>
<tr><td>parameter:</td><td>string</td><td>String</td><td colspan="2">mandatory</td></tr>
</table>

## Documentation Functions
<table>
<tr><th colspan="5">engine.tag.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the tags within a TemplateEngine</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>example:</td><td colspan="4">{{ engine.tag.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>

<table>
<tr><th colspan="5">engine.baseType.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the basic types that can be used within a ExpressionTag of a TemplateEngine</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>example:</td><td colspan="4">{{ engine.baseType.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>

<table>
<tr><th colspan="5">engine.function.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the functions that can be used within a ExpressionTag of a TemplateEngine</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>example:</td><td colspan="4">{{ engine.function.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>
