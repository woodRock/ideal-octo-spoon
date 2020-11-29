import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock/model/ThemeModel.dart';

void main() {
  group('default value', () {
    test('should be purple', () {
      final test = ThemeModel();
      expect(test.theme, equals(Colors.purple));
    });
  });

  group('set', () {
    test('should update the current theme', () {
      final test = ThemeModel();
      final newColor = Colors.black;
      test.theme = newColor;
      expect(test.theme, equals(newColor));
    });
  });
}
