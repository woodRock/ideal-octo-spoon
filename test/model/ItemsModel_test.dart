import 'package:flutter_test/flutter_test.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/model/ItemsModel.dart';

void main() {
  Item testItem = Item.fromJSON(
      {"name": "Milk", "count": 1, "essential": false, "cost": 5.0});

  group('initial ItemModel', () {
    test('should start with no items', () {
      final items = ItemsModel();
      expect(items.length, equals(0));
    });
  });

  group('adding items', () {
    test('should increase the total length', () {
      final items = ItemsModel();
      final startingLength = items.length;
      items.add(testItem);
      expect(items.length, greaterThan(startingLength));
    });

    test('should increase the total cost', () {
      final items = ItemsModel();
      final startingPrice = items.totalCost();
      items.add(testItem);
      expect(items.totalCost(), greaterThan(startingPrice));
      expect(items.totalCost(), equals(testItem.count * testItem.cost));
    });
  });

  group('total cost', () {
    test('should calculate as the sum of count * cost for each item', () {
      final items = ItemsModel();
      final startingPrice = items.totalCost();
      items.add(testItem);
      expect(items.totalCost(), greaterThan(startingPrice));
      expect(items.totalCost(), equals(testItem.count * testItem.cost));
    });

    test('should return zero for an empty list of stock', () {
      final items = ItemsModel();
      items.removeAll();
      expect(items.totalCost(), equals(0.0));
    });
  });

  group('count', () {
    test('should be zero after resetAll has been called', () {
      final items = ItemsModel();
      items.add(testItem);
      final first = items.get(0);
      final startingCount = first.count;
      items.resetAll();
      expect(first.count, lessThan(startingCount));
      expect(first.count, equals(0));
    });
  });
}