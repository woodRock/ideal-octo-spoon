import 'package:flutter_test/flutter_test.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/model/ItemsModel.dart';

void main() {
  Item testItem = Item.fromJSON(
      {"name": "Milk", "count": 1, "essential": false, "cost": 5.0});

  test('stock starts with no items', () {
    final items = ItemsModel();
    expect(items.length, 0);
  });

  test('adding item increases the length', () {
    final items = ItemsModel();
    final startingLength = items.length;
    items.add(testItem);
    expect(items.length, greaterThan(startingLength));
  });

  test('adding item increases total cost', () {
    final items = ItemsModel();
    final startingPrice = items.totalCost();
    items.add(testItem);
    expect(items.totalCost(), greaterThan(startingPrice));
    expect(items.totalCost(), testItem.count * testItem.cost);
  });

  test('total cost is calculated as the sum of count * cost for each item', () {
    final items = ItemsModel();
    final startingPrice = items.totalCost();
    items.add(testItem);
    expect(items.totalCost(), greaterThan(startingPrice));
    expect(items.totalCost(), testItem.count * testItem.cost);
  });

  test('reset all function sets the count for each item to zero', () {
    final items = ItemsModel();
    items.add(testItem);
    final startingCount = items.get(0).count;
    items.resetAll();
    expect(items.get(0).count, lessThan(startingCount));
    expect(items.get(0).count, 0);
  });
}
