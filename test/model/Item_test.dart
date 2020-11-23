import 'package:flutter_test/flutter_test.dart';
import 'package:stock/model/Item.dart';

void main() {
  Item testItem() => Item.fromJSON(
      {"name": "Milk", "count": 1, "essential": false, "cost": 5.0});

  group('fromFactory', () {
    test('should set essential to true by default', () {
      Item item = Item.fromFactory();
      expect(item.essential, equals(true));
    });

    test('should not initialize the other fields', () {
      Item item = Item.fromFactory();
      bool otherFieldsAllNull =
          item.name == null && item.cost == null && item.cost == null;
      expect(otherFieldsAllNull, equals(true));
    });
  });

  group('totalCost', () {
    test('should be zero for items with zero count', () {
      Item test = testItem();
      test.count = 0;
      expect(test.totalCost(), equals(0.0));
    });

    test('should be zero for items with zero cost', () {
      Item test = testItem();
      test.cost = 0;
      expect(test.totalCost(), equals(0.0));
    });

    test('should be cost * count', () {
      Item test = testItem();
      expect(test.totalCost(), equals(test.cost * test.count));
    });
  });

  group('increment', () {
    test('should increase count by one with increment', () {
      Item test = testItem();
      int startingCount = test.count;
      test.increment();
      expect(test.count, greaterThan(startingCount));
      expect(test.count, equals(startingCount + 1));
    });

    test('should increase the total cost', () {
      Item test = testItem();
      double startingCost = test.totalCost();
      test.increment();
      expect(test.totalCost(), greaterThan(startingCost));
      expect(test.totalCost(), equals(startingCost * 2));
    });
  });

  group('reset', () {
    test('should make the count zero', () {
      Item test = testItem();
      test.reset();
      expect(test.count, equals(0));
    });

    test('should make the total cost zero', () {
      Item test = testItem();
      test.reset();
      expect(test.totalCost(), equals(0.0));
    });
  });

  group('toString', () {
    test('should display a list friendly item', () {
      Item test = testItem();
      expect(test.toString(), equals("- Milk\n"));
    });

    test('should display count when greater than 1', () {
      Item test = testItem();
      test.increment();
      expect(test.toString(), equals("- Milk x2\n"));
    });
  });
}
