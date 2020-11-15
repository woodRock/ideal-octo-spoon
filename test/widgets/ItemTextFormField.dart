import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock/widgets/ItemTextFormField.dart';

void main() {
  ItemTextFormField tested = ItemTextFormField(
    'count',
    TextInputType.number,
    Icons.bar_chart,
    null,
    (value) => print(value),
    null,
  );

  group('isNumeric function', () {
    test('should return false for a non-numeric value', () {
      expect(tested.isNumeric('x'), false);
    });

    test('should return true for a numeric value', () {
      expect(tested.isNumeric('2'), true);
    });
  });

  group('number validator', () {
    test('should be a valid number', () {
      expect(tested.numericValidator('2'), null);
    });

    test('should not be a valid number', () {
      expect(tested.numericValidator('x'), isNot(null));
    });
  });

  group('empty string validator', () {
    test('should be a valid string', () {
      expect(tested.emptyValidator('x'), null);
    });

    test('should not be a valid string', () {
      expect(tested.emptyValidator(''), isNot(null));
    });
  });
}
