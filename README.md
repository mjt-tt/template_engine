[//]: # (This document was generated by template_engine/tool/generate_documentation.dart using template_engine/doc/template/README.md.template)
[![Pub Package](https://img.shields.io/pub/v/template_engine)](https://pub.dev/packages/template_engine)
[![Code Repository](https://img.shields.io/badge/repository-git%20hub-informational)](https://github.com/domain-centric/template_engine)
[![GitHub Stars](https://img.shields.io/github/stars/domain-centric/template_engine)](https://github.com/domain-centric/template_engine/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/domain-centric/template_engine)](https://github.com/domain-centric/template_engine/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/domain-centric/template_engine)](https://github.com/domain-centric/template_engine/pulls)
[![GitHub License](https://img.shields.io/badge/license-MIT-informational)](https://github.com/domain-centric/template_engine/blob/main/LICENSE)

![](https://raw.githubusercontent.com/domain-centric/template_engine/main/doc/template/template_engine.png)

[//]: # (TODO: This text should be imported from the dart doc of the TemplateEngine class using document_generator package)
# template_engine
A flexible Dart library to parse templates and render output such as:
* [Html](https://en.wikipedia.org/wiki/HTML)
* [Programming code](https://en.wikipedia.org/wiki/Programming_language)
* [Markdown](https://en.wikipedia.org/wiki/Markdown)
* [Xml](https://en.wikipedia.org/wiki/XML), [Json](https://en.wikipedia.org/wiki/JSON), [Yaml](https://en.wikipedia.org/wiki/YAML)
* Etc...

# Features
* Template expressions that can contain (combinations of):
  * Data types
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
  var template = TextTemplate('Hello {{ERROR}}.');
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
just like the popular template engines [Mustache](https://mustache.github.io/) 
and [Handlebars](https://handlebarsjs.com).

You can also define alternative tag brackets in the TemplateEngine constructor
parameters. See TemplateEngine.tagStart and TemplateEngine.tagEnd.

It is recommended to use a start and end combination that is not used
elsewhere in your templates, e.g.: Do not use < > as tag start and end
if your template contains HTML or XML.

The TemplateEngine comes with default tags. You can replace or add your
own tags by manipulating the the TemplateEngine.tags field.

<table>
<tr><th colspan="2">ExpressionTag</th></tr>
<tr><td>description:</td><td>Evaluates an expression that can contain:<br>* Data Types (e.g. boolean, number or String)<br>* Constants (e.g. pi)<br>* Variables (e.g. person.name )<br>* Operators (e.g. + - * /)<br>* Functions (e.g. cos(7) )<br>* or any combination of the above</td></tr>
<tr><td>expression example:</td><td colspan="4">The volume of a sphere = {{ round( (3/4) * pi * (radius ^ 3) )}}.</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/tag_expression_parser_test.dart">tag_expression_parser_test.dart</a></td></tr>
</table>


# Data types in tag expressions
[//]: # (TODO: This text should be imported from the dart doc of the DataType class using document_generator package)
A [data type](https://en.wikipedia.org/wiki/Data_type) defines what the
possible values an expression, such as a variable, operator
or a function call, might take.

The TemplateEngine supports several default DataTypes.

## Custom DataTypes
You can adopt existing DataTypes or add your own custom DataTypes by 
manipulating the TemplateEngine.dataTypes field.
See [Example](https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/data_type/custom_data_type_test.dart). 

## Available DataTypes
<table>
<tr><th colspan="2">String</th></tr>
<tr><td>description:</td><td>A form of data containing a sequence of characters</td></tr>
<tr><td>syntax:</td><td>A string is declared with a chain of characters, surrounded by two single (') or double (") quotes to indicate the start and end of a string. In example: 'Hello' or "Hello"</td></tr>
<tr><td>example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/data_type/string_test.dart">string_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">Number</th></tr>
<tr><td>description:</td><td>A form of data to express the size of something.</td></tr>
<tr><td>syntax:</td><td>A number is declared with:<br>* optional: positive (e.g. +12) or negative (e.g. -12) prefix or no prefix (12=positive)<br>* one or more digits (e.g. 12)<br>* optional fragments (e.g. 0.12)<br>* optional: scientific notation: the letter E is used to mean"10 to the power of." (e.g. 1.314E+1 means 1.314 * 10^1which is 13.14).<br></td></tr>
<tr><td>example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/data_type/num_test.dart">num_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">Boolean</th></tr>
<tr><td>description:</td><td>A form of data with only two possible values: true or false</td></tr>
<tr><td>syntax:</td><td>A boolean is declared with the word true or false. The letters are case insensitive.</td></tr>
<tr><td>example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/data_type/bool_test.dart">bool_test.dart</a></td></tr>
</table>


# Constants in tag expressions
[//]: # (TODO: This text should be imported from the dart doc of the Constant class using document_generator package)
A Constant is a value that does not change value over time.

The TemplateEngine comes with several mathematical constants.

## Custom Constants
You can create and add your own Constants by
manipulating the TemplateEngine.constants field.
See [Example](https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/custom_function_test.dart).

## Available Constants
<table>
<tr><th colspan="2">e</th></tr>
<tr><td>description:</td><td>Base of the natural logarithms.</td></tr>
<tr><td>return type:</td><td>double</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/constant/e_test.dart">e_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">ln10</th></tr>
<tr><td>description:</td><td>Natural logarithm of 10.</td></tr>
<tr><td>return type:</td><td>double</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/constant/ln10_test.dart">ln10_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">ln2</th></tr>
<tr><td>description:</td><td>Natural logarithm of 2.</td></tr>
<tr><td>return type:</td><td>double</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/constant/ln2_test.dart">ln2_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">log10e</th></tr>
<tr><td>description:</td><td>Base-10 logarithm of e.</td></tr>
<tr><td>return type:</td><td>double</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/constant/log10e_test.dart">log10e_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">log2e</th></tr>
<tr><td>description:</td><td>Base-2 logarithm of e.</td></tr>
<tr><td>return type:</td><td>double</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/constant/log2e_test.dart">log2e_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">pi</th></tr>
<tr><td>description:</td><td>The ratio of a circle's circumference to its diameter</td></tr>
<tr><td>return type:</td><td>double</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/constant/pi_test.dart">pi_test.dart</a></td></tr>
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
* [Variable Example](https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/variable/variable_test.dart)
* [Nested Variable Example](https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/variable/nested_variable_test.dart)

# Functions in tag expressions
[//]: # (TODO: This text should be imported from the dart doc of the ExpressionFunction class using document_generator package)
A function is a piece of dart code that performs a specific task. 
So a function can basically do anything that dart code can do.
 
A function can be used anywhere in an tag expression
wherever that particular task should be performed.
 
The TemplateEngine supports several default functions.
 
## Custom Functions
You can adopt existing functions or add your own custom functions by 
manipulating the TemplateEngine.functionGroups field.
See [Example](https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/custom_function_test.dart). 

## Available Functions
## Math Functions
<table>
<tr><th colspan="5">exp</th></tr>
<tr><td>description:</td><td colspan="4">Returns the natural exponent e, to the power of the value</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{exp(7)}} should render: 1096.6331584284585</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/exp_test.dart">exp_test.dart</a></td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">log</th></tr>
<tr><td>description:</td><td colspan="4">Returns the natural logarithm of the value</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{log(7)}} should render: 1.9459101490553132</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/log_test.dart">log_test.dart</a></td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">sin</th></tr>
<tr><td>description:</td><td colspan="4">Returns the sine of the radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{sin(7)}} should render: 0.6569865987187891</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/sin_test.dart">sin_test.dart</a></td></tr>
<tr><td>parameter:</td><td>radians</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">asin</th></tr>
<tr><td>description:</td><td colspan="4">Returns the values arc sine in radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{asin(0.5)}} should render: 0.5235987755982989</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/asin_test.dart">asin_test.dart</a></td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">cos</th></tr>
<tr><td>description:</td><td colspan="4">Returns the cosine of the radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{cos(7)}} should render: 0.7539022543433046</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/cos_test.dart">cos_test.dart</a></td></tr>
<tr><td>parameter:</td><td>radians</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">acos</th></tr>
<tr><td>description:</td><td colspan="4">Returns the values arc cosine in radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{acos(0.5)}} should render: 1.0471975511965979</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/acos_test.dart">acos_test.dart</a></td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">tan</th></tr>
<tr><td>description:</td><td colspan="4">Returns the the tangent of the radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{tan(7)}} should render: 0.8714479827243188</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/tan_test.dart">tan_test.dart</a></td></tr>
<tr><td>parameter:</td><td>radians</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">atan</th></tr>
<tr><td>description:</td><td colspan="4">Returns the values arc tangent in radians</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{atan(0.5)}} should render: 0.4636476090008061</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/atan_test.dart">atan_test.dart</a></td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">sqrt</th></tr>
<tr><td>description:</td><td colspan="4">Returns the positive square root of the value.</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{sqrt(9)}} should render: 3.0</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/sqrt_test.dart">sqrt_test.dart</a></td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

<table>
<tr><th colspan="5">round</th></tr>
<tr><td>description:</td><td colspan="4">Returns the a rounded number.</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{round(4.445)}} should render: 4</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/math/round_test.dart">round_test.dart</a></td></tr>
<tr><td>parameter:</td><td>value</td><td>number</td><td colspan="2">mandatory</td></tr>
</table>

## String Functions
<table>
<tr><th colspan="5">length</th></tr>
<tr><td>description:</td><td colspan="4">Returns the length of a string</td></tr>
<tr><td>return type:</td><td colspan="4">number</td></tr>
<tr><td>expression example:</td><td colspan="4">{{length("Hello")}} should render: 5</td></tr>
<tr><td>code example:</td><td colspan="4"><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/function/string/length_test.dart">length_test.dart</a></td></tr>
<tr><td>parameter:</td><td>string</td><td>String</td><td colspan="2">mandatory</td></tr>
</table>

## Documentation Functions
<table>
<tr><th colspan="5">engine.tag.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the tags within a TemplateEngine</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>expression example:</td><td colspan="4">{{ engine.tag.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>

<table>
<tr><th colspan="5">engine.dataType.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the data types that can be used within a ExpressionTag of a TemplateEngine</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>expression example:</td><td colspan="4">{{ engine.dataType.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>

<table>
<tr><th colspan="5">engine.constant.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the constants that can be used within a ExpressionTag of a TemplateEngine</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>expression example:</td><td colspan="4">{{ engine.constant.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>

<table>
<tr><th colspan="5">engine.function.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the functions that can be used within a ExpressionTag of a TemplateEngine</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>expression example:</td><td colspan="4">{{ engine.function.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>

<table>
<tr><th colspan="5">engine.operator.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the operators that can be used within a ExpressionTag of a TemplateEngine</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>expression example:</td><td colspan="4">{{ engine.operator.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>

<table>
<tr><th colspan="5">engine.example.documentation</th></tr>
<tr><td>description:</td><td colspan="4">Generates markdown documentation of all the examples. This could be used to generate example.md file.</td></tr>
<tr><td>return type:</td><td colspan="4">String</td></tr>
<tr><td>expression example:</td><td colspan="4">{{ engine.example.documentation() }}</td></tr>
<tr><td>parameter:</td><td>titleLevel</td><td>number</td><td>optional (default=1)</td><td>The level of the tag title</td></tr>
</table>


# Operator
 An operator behaves generally like functions,
  but differs syntactically or semantically.

 Common simple examples include arithmetic (e.g. addition with +) and
 logical operations (e.g. &).

 An operator can be used anywhere in an tag expression
 wherever that particular Operator should be performed.

 The TemplateEngine supports several standard operators.

 ## Custom Operators
 You can adopt existing operators or add your own custom operators by
 manipulating the TemplateEngine.operatorGroups field.
 See [custom_operator_test.dart](https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/custom_operator_test.dart).

## Available Operators
## Parentheses
<table>
<tr><th colspan="2">operator: ( ... )</th></tr>
<tr><td>description:</td><td>Groups expressions together so that the are calculated first</td></tr>
<tr><td>expression example:</td><td>{{(2+1)*3}} should render: 9</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/parentheses_test.dart">parentheses_test.dart</a></td></tr>
</table>

## Prefixes
<table>
<tr><th colspan="2">operator: +</th></tr>
<tr><th colspan="2">parameter type: number</th></tr>
<tr><td>description:</td><td>Optional prefix for positive numbers</td></tr>
<tr><td>expression example:</td><td>{{+3}} should render: 3</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/prefix/positive_test.dart">positive_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">operator: -</th></tr>
<tr><th colspan="2">parameter type: number</th></tr>
<tr><td>description:</td><td>Prefix for a negative number</td></tr>
<tr><td>expression example:</td><td>{{-3}} should render: -3</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/prefix/negative_test.dart">negative_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">operator: !</th></tr>
<tr><th colspan="2">parameter type: boolean</th></tr>
<tr><td>description:</td><td>Prefix to invert a boolean, e.g.: !true =false</td></tr>
<tr><td>expression example:</td><td>{{!true}} should render: false</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/prefix/not_test.dart">not_test.dart</a></td></tr>
</table>

## Multiplication
<table>
<tr><th colspan="2">operator: ^</th></tr>
<tr><th colspan="2">parameter type: number</th></tr>
<tr><td>description:</td><td>Calculates a number to the power of the exponent number</td></tr>
<tr><td>expression example:</td><td>{{2^3}} should render: 8</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/multiplication/num_power_test.dart">num_power_test.dart</a></td></tr>
<tr><th colspan="2">parameter type: boolean</th></tr>
<tr><td>description:</td><td>Logical XOR with two booleans</td></tr>
<tr><td>expression example:</td><td>{{true^false}} should render: true</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/multiplication/bool_xor_test.dart">bool_xor_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">operator: *</th></tr>
<tr><th colspan="2">parameter type: number</th></tr>
<tr><td>description:</td><td>Multiplies 2 numbers</td></tr>
<tr><td>expression example:</td><td>{{2*3}} should render: 6</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/multiplication/num_multiply_test.dart">num_multiply_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">operator: /</th></tr>
<tr><th colspan="2">parameter type: number</th></tr>
<tr><td>description:</td><td>Divides 2 numbers</td></tr>
<tr><td>expression example:</td><td>{{6/4}} should render: 1.5</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/multiplication/num_divide_test.dart">num_divide_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">operator: %</th></tr>
<tr><th colspan="2">parameter type: number</th></tr>
<tr><td>description:</td><td>Calculates the modulo (rest value of a division)</td></tr>
<tr><td>expression example:</td><td>{{8%3}} should render: 2</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/multiplication/num_modulo_test.dart">num_modulo_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">operator: &</th></tr>
<tr><th colspan="2">parameter type: boolean</th></tr>
<tr><td>description:</td><td>Logical AND operation on two booleans</td></tr>
<tr><td>expression example:</td><td>{{true&true}} should render: true</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/multiplication/bool_and_test.dart">bool_and_test.dart</a></td></tr>
<tr><th colspan="2">parameter type: String</th></tr>
<tr><td>description:</td><td>Concatenates two strings</td></tr>
<tr><td>expression example:</td><td>{{"Hel"&"lo"}} should render: Hello</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/multiplication/string_concatenate_test.dart">string_concatenate_test.dart</a></td></tr>
</table>

## Additions
<table>
<tr><th colspan="2">operator: +</th></tr>
<tr><th colspan="2">parameter type: number</th></tr>
<tr><td>description:</td><td>Adds two numbers</td></tr>
<tr><td>expression example:</td><td>{{2+3}} should render: 5</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/addition/num_addition_test.dart">num_addition_test.dart</a></td></tr>
<tr><th colspan="2">parameter type: String</th></tr>
<tr><td>description:</td><td>Concatenates two strings</td></tr>
<tr><td>expression example:</td><td>{{"Hel"+"lo"}} should render: Hello</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/addition/string_concatenate_test.dart">string_concatenate_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">operator: -</th></tr>
<tr><th colspan="2">parameter type: number</th></tr>
<tr><td>description:</td><td>Subtracts two numbers</td></tr>
<tr><td>expression example:</td><td>{{5-3}} should render: 2</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/addition/num_subtract_test.dart">num_subtract_test.dart</a></td></tr>
</table>

<table>
<tr><th colspan="2">operator: |</th></tr>
<tr><th colspan="2">parameter type: boolean</th></tr>
<tr><td>description:</td><td>Logical OR operation on two booleans</td></tr>
<tr><td>expression example:</td><td>{{false|true}} should render: true</td></tr>
<tr><td>code example:</td><td><a href="https://github.com/domain-centric/template_engine/blob/main/test/src/parser/tag/expression/operator/addition/bool_or_test.dart">bool_or_test.dart</a></td></tr>
</table>
