import 'package:flutter_test/flutter_test.dart';
import 'package:stock/model/Item.dart';

void main() {
  Item testItem = Item.fromJSON(
      {"name": "Milk", "count": 1, "essential": false, "cost": 5.0});

  test('should make the count zero after a reset', () {
    testItem.reset();
    expect(testItem.count, equals(0));
  });

  test('should by essential by default when made from factory', () {
    Item item = Item.fromFactory();
    expect(item.essential, equals(true));
  });

  test('should calculate total cost as count * cost', () {
    expect(testItem.totalCost(), equals(testItem.cost * testItem.count));
  });

  test('should increase count by one with increment', () {
    int startingCount = testItem.count;
    testItem.increment();
    expect(testItem.count, greaterThan(startingCount));
    expect(testItem.count, equals(startingCount + 1));
  });
}
