import 'package:flutter_test/flutter_test.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/model/ItemsModel.dart';

void main(){
  test('adding item increases total cost', () {
    final items = ItemsModel();
    final startingPrice = items.totalCost();
    items.addListener(() {
      expect(items.totalCost(), greaterThan(startingPrice));
    });
    items.add(Item.fromJSON(
      {
        "name": "Milk",
        "count": 0,
        "essential": false,
        "cost": 5.0
      }
    ));
  });
}