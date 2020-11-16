import 'package:flutter_test/flutter_test.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/model/ItemsModel.dart';

void main() {
  Item testItem = Item.fromJSON(
      {"name": "Milk", "count": 1, "essential": false, "cost": 5.0});

  Item itemWithCount = Item.fromJSON(
      {"name": "Milk", "count": 2, "essential": false, "cost": 5.0});

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

  group('FileIO', () {
    test('should be able to save and load an item', () async {
      final items = ItemsModel();
      items.add(testItem);
      items.save();
      items.removeAll();
      expect(items.length, equals(0));
      // TODO  work out how to test async functions properly
    });
  });

  group('toList', () {
    test('should return empty string for an empty stock', () {
      final items = ItemsModel();
      expect(items.toList(), equals(''));
    });

    test('should return a list containing one item', () {
      final items = ItemsModel();
      items.add(testItem);
      expect(items.toList(), equals('- ${testItem.name}\n'));
    });

    test('should display the count if larger than 1', () {
      final items = ItemsModel();
      items.add(itemWithCount);
      expect(items.toList(),
          equals('- ${itemWithCount.name} x${itemWithCount.count}\n'));
    });

    test('should display each item on a new line', () {
      final items = ItemsModel();
      items.add(testItem);
      items.add(testItem);
      expect(
          items.toList(), equals('- ${testItem.name}\n- ${testItem.name}\n'));
    });
  });
}
