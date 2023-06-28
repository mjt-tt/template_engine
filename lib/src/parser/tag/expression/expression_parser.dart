import 'dart:math';

import 'package:petitparser/petitparser.dart';
import 'package:template_engine/template_engine.dart';

Parser<bool> boolParser() => (whitespace().star() &
        (stringIgnoreCase('true') | stringIgnoreCase('false'))
            .flatten('boolean expected'))
    .map((values) => values[1].toLowerCase() == 'true');

Parser<num> numberParser() => (digit().plus() &
        (char('.') & digit().plus()).optional() &
        (pattern('eE') & pattern('+-').optional() & digit().plus()).optional())
    .flatten('number expected')
    .trim()
    .map((value) => num.parse(value));

Parser<String> quotedStringParser() =>
    ((char("'") & any().starLazy(char("'")).flatten() & char("'")) |
            (char('"') & any().starLazy(char('"')).flatten() & char('"')))
        .map((values) => values[1]);

/// Common mathematical constants.
final constants = {
  'e': e,
  'pi': pi,
};

Parser<Expression<num>> constantParser() {
  return ChoiceParser(constants.keys.map((name) => string(name)))
      .flatten('constant expected')
      .trim()
      .map((name) => Value<num>(constants[name]!));
}

Parser<Expression> expressionParser() {
  final builder = ExpressionBuilder<Expression>();
  builder
    ..primitive(quotedStringParser().map((string) => Value<String>(string)))
    ..primitive(numberParser().map((number) => Value<num>(number)))
    ..primitive(boolParser().map((boolean) => Value<bool>(boolean)))
    ..primitive(constantParser())
    ..primitive((letter() & word().star())
        .flatten('variable expected')
        .trim()
        .map((name) => Variable2<num>(name)));

  var group = builder.group();
  for (var definition in numFunctions()) {
    group.wrapper(
        seq2(
          string(definition.name, 'expected function name: ${definition.name}'),
          char('(').trim(),
        ),
        char(')').trim(),
        (left, parameterValue, right) =>
            TagFunction2<num>(definition, parameterValue));
  }

  ParenthesesOperator().addParser(group);
  group = builder.group();
  PositiveOperator().addParser(group);
  NegativeOperator().addParser(group);
  group = builder.group();
  PowerOperator().addParser(group);
  builder.group()
    ..left(
        char('*').trim(),
        (a, op, b) => BinaryOperator<num>(
            '*', a as Expression<num>, b as Expression<num>, (x, y) => x * y))
    ..left(
        char('/').trim(),
        (a, op, b) => BinaryOperator<num>(
            '/', a as Expression<num>, b as Expression<num>, (x, y) => x / y))
    ..left(
        char('%').trim(),
        (a, op, b) => BinaryOperator<num>(
            '%', a as Expression<num>, b as Expression<num>, (x, y) => x % y));
  builder.group()
    ..left(
        char('+').trim(),
        (a, op, b) => BinaryOperator<num>(
            '+', a as Expression<num>, b as Expression<num>, (x, y) => x + y))
    ..left(
        char('-').trim(),
        (a, op, b) => BinaryOperator<num>(
            '-', a as Expression<num>, b as Expression<num>, (x, y) => x - y));
  return builder.build();
}
