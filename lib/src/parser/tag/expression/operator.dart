import 'dart:math';

import 'package:petitparser/petitparser.dart';
import 'package:template_engine/template_engine.dart';

class NegativeNumberExpression extends Expression {
  final Expression valueExpression;

  NegativeNumberExpression(this.valueExpression);

  @override
  Object eval(Map<String, Object> variables) {
    var value = valueExpression.eval(variables);
    if (value is num) {
      return -value;
    }
    throw OperatorException(
        'A number expected after the - operator'); //TODO position
  }
}

class OperatorFunction<PARAMETER_TYPE extends Object> {
  ///
  final String description;
  final Object Function(PARAMETER_TYPE left, PARAMETER_TYPE right) function;

  OperatorFunction(this.description, this.function);

  bool parameterTypesMatch(Object left, Object right) =>
      left is PARAMETER_TYPE && right is PARAMETER_TYPE;

  Object eval(Object leftValue, Object rightValue) =>
      function(leftValue as PARAMETER_TYPE, rightValue as PARAMETER_TYPE);
}

/// delegates the work to one of the [operatorFunctions] that can process
/// the correct types of the evaluated [left] and [right] values.
class ConditionalOperatorExpression extends Expression {
  final List<OperatorFunction> operatorFunctions;
  final String operator;
  final Expression left;
  final Expression right;

  ConditionalOperatorExpression(
      {required this.operator,
      required this.operatorFunctions,
      required this.left,
      required this.right});

  @override
  Object eval(Map<String, Object> variables) {
    var leftValue = left.eval(variables);
    var rightValue = right.eval(variables);

    for (var operatorFunction in operatorFunctions) {
      if (operatorFunction.parameterTypesMatch(leftValue, rightValue)) {
        return operatorFunction.eval(leftValue, rightValue);
      }
    }
    throw OperatorException(
        '$operator Operator is used for an unsupported types. See documentation.');
  }
}

/// A value that needs to be calculated (evaluated)
/// from 2 expressions that return a number
class TwoNumberExpression extends Expression {
  final String operator;
  final Expression left;
  final Expression right;
  final num Function(num left, num right) function;

  TwoNumberExpression(
      {required this.operator,
      required this.left,
      required this.right,
      required this.function});

  @override
  Object eval(Map<String, Object> variables) {
    var leftValue = left.eval(variables);
    bool leftIsNum = leftValue is num;
    var rightValue = right.eval(variables);
    bool rightIsNum = rightValue is num;
    if (leftIsNum && rightIsNum) {
      return function(leftValue, rightValue);
    }

    if (!leftIsNum && !rightIsNum) {
      return OperatorException(
          'left and right of the $operator operator must be a number');
    }
    if (leftIsNum) {
      return OperatorException(
          'left of the $operator operator must be a number');
    }
    return OperatorException(
        'right of the $operator operator must be a number');
  }

  @override
  String toString() => 'TwoNumberExpression{$operator}';
}

/// An [Operator] behaves generally like functions,
/// but differs syntactically or semantically.
abstract class Operator<T extends Object> implements Expression<T> {
  // for documentation only
}

/// An [Operator] that uses one [value]
/// e.g. making a number negative
class UnaryOperator<T extends Object> extends Operator<T> {
  UnaryOperator(this.name, this.value, this.function);

  final String name;
  final Expression<T> value;
  final T Function(T value) function;

  @override
  T eval(Map<String, Object> variables) => function(value.eval(variables));

  @override
  String toString() => 'UnaryOperator{$name}';
}

/// An [Operator] that uses the two values [left] and [right]
/// An example of an operation: a + b
class BinaryOperator<T extends Object> extends Operator<T> {
  BinaryOperator(this.name, this.left, this.right, this.function);

  final String name;
  final Expression<T> left;
  final Expression<T> right;
  final T Function(T left, T right) function;

  @override
  T eval(Map<String, Object> variables) =>
      function(left.eval(variables), right.eval(variables));

  @override
  String toString() => 'BinaryOperatorExpression{$name}';
}

/// An [Operator] behaves generally like functions,
/// but differs syntactically or semantically.
abstract class Operator2 {
  final String operator;

  /// a description and an example for each type.
  /// e.g. example [descriptions] for an + operator:
  /// * Adds two numbers, e.g.: 2+3=5
  /// * Concatenates two strings, e.g.: 'Hel'+'lo'="Hello"
  final List<String> descriptions;

  Operator2({
    required this.operator,
    required this.descriptions,
  });

  addParser(ExpressionGroup<Expression> group);

  @override
  String toString() => 'Operator{$operator}';
}

class OperatorException implements Exception {
  late String message;

  OperatorException(this.message);
}

class ParenthesesOperator extends Operator2 {
  ParenthesesOperator()
      : super(operator: '()', descriptions: [
          'Groups expressions together so that the are calculated first, e.g.: (2+1)*3=9 while 2+1*3=5'
        ]);

  @override
  addParser(ExpressionGroup<Expression<Object>> group) {
    group.wrapper(
        char('(').trim(), char(')').trim(), (left, value, right) => value);
  }
}

class PositiveOperator extends Operator2 {
  PositiveOperator()
      : super(operator: '+ prefix', descriptions: [
          'Optional prefix for positive numbers, e.g.: +3 =3'
        ]);

  @override
  addParser(ExpressionGroup<Expression<Object>> group) {
    group.prefix(char('+').trim(), (op, a) => a);
  }
}

class NegativeOperator extends Operator2 {
  NegativeOperator()
      : super(
            operator: '- prefix',
            descriptions: ['Prefix for a negative number, e.g.: -2 =-2']);

  @override
  addParser(ExpressionGroup<Expression<Object>> group) {
    group.prefix(char('-').trim(), (op, a) => NegativeNumberExpression(a));
  }
}

class PowerOperator extends Operator2 {
  PowerOperator()
      : super(
          operator: '^',
          descriptions: [
            'Calculates a number to the power of the exponent number, e.g.: 2^3=8'
          ],
        );

  @override
  void addParser(ExpressionGroup<Expression> group) {
    group.right(
        char('^').trim(),
        (left, op, right) => TwoNumberExpression(
            operator: operator, left: left, right: right, function: pow));
  }
}

class MultiplyOperator extends Operator2 {
  MultiplyOperator()
      : super(
          operator: '*',
          descriptions: ['Multiplies 2 numbers, e.g.: 2*3=6'],
        );

  @override
  void addParser(ExpressionGroup<Expression> group) {
    group.left(
        char('*').trim(),
        (left, op, right) => TwoNumberExpression(
            operator: operator,
            left: left,
            right: right,
            function: (x, y) => x * y));
  }
}

class DivideOperator extends Operator2 {
  DivideOperator()
      : super(
          operator: '/',
          descriptions: ['Divides 2 numbers, e.g.: 6*4=1.5'],
        );

  @override
  void addParser(ExpressionGroup<Expression> group) {
    group.left(
        char('/').trim(),
        (left, op, right) => TwoNumberExpression(
            operator: operator,
            left: left,
            right: right,
            function: (x, y) => x / y));
  }
}

class ModuloOperator extends Operator2 {
  ModuloOperator()
      : super(
          operator: '%',
          descriptions: [
            'Calculates the modulo (rest value of a division), e.g.: 8%3=2'
          ],
        );

  @override
  void addParser(ExpressionGroup<Expression> group) {
    group.left(
        char('%').trim(),
        (left, op, right) => TwoNumberExpression(
            operator: operator,
            left: left,
            right: right,
            function: (x, y) => x % y));
  }
}

class AddOperator extends Operator2 {
  static final operatorFunctions = [
    OperatorFunction<num>('Adds two numbers, e.g.: 2+3=5', (x, y) => x + y),
    OperatorFunction<String>(
        'Concatenates two strings, e.g.: "Hel"+"lo"="Hello"', (x, y) => '$x$y')
  ];

  AddOperator()
      : super(
            operator: '+',
            descriptions: operatorFunctions.map((f) => f.description).toList());

  @override
  void addParser(ExpressionGroup<Expression> group) {
    group.left(
        char('+').trim(),
        (left, op, right) => ConditionalOperatorExpression(
              operator: operator,
              operatorFunctions: operatorFunctions,
              left: left,
              right: right,
            ));
  }
}

class SubtractOperator extends Operator2 {
  SubtractOperator()
      : super(
          operator: '-',
          descriptions: ['Subtracts two numbers, e.g.: 5-3=2'],
        );

  @override
  void addParser(ExpressionGroup<Expression> group) {
    group.left(
        char('-').trim(),
        (left, op, right) => TwoNumberExpression(
            operator: operator,
            left: left,
            right: right,
            function: (x, y) => x - y));
  }
}
