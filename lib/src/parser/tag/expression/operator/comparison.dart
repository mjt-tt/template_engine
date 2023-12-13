import 'package:template_engine/template_engine.dart';

class Comparisons extends OperatorGroup {
  Comparisons() : super('Comparisons', [EqualsOperator()]);
}

class EqualsOperator extends OperatorWith2Values {
  EqualsOperator()
      : super('==', OperatorAssociativity.left, [
          //TODO is left ok, should be none???
          TwoValueOperatorVariant<Object, Object>(
              description: 'Checks if two values are equal',
              expressionExample: '{{5==2+3}}',
              expressionExampleResult: 'true',
              codeExample: ProjectFilePath(
                  'test/src/parser/tag/expression/operator/comparison/'
                  'equals_test.dart'),
              function: (left, right) => left == right)
        ]);
}
