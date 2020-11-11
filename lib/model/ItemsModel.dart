import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:stock/model/Item.dart';

/// This bloc stores the state of the items.
class ItemsModel extends ChangeNotifier {

  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(this._items);

  int get length => this._items.length;

  /// Retrieve an item by index.
  Item get(int i) {
    return this._items[i];
  }

  /// Retrieve an item by object reference.
  Item getByItem(Item i) {
    Item item;
    this._items.forEach((element) {
      if (element == i) {
        item = element;
      }
    });
    return item;
  }

  /// Calculates the total cost for the current stock.
  double totalCost() {
    double sum = 0;
    this._items.forEach((e) => sum += e.totalCost());
    return sum;
  }

  /// Increment an item by object reference.
  increment(Item item) {
    getByItem(item).increment();
    notifyListeners();
  }

  /// Reset the count of an item by object reference.
  reset(Item item) {
    getByItem(item).reset();
    notifyListeners();
  }

  /// Reset the count for the entire stock.
  resetAll() {
    this._items.forEach((item) => item.reset() );
    notifyListeners();
  }

  /// Provide a new list of items.
  set(List<Item> items){
    this.removeAll();
    items.forEach((item) => add(item) );
    this.sort();
    notifyListeners();
  }

  /// Include an additional item to the stock.
  add(Item item) {
    this._items.add(item);
    this.sort();
    notifyListeners();
  }

  /// Remove an item from the stock
  delete(Item i) {
    this._items.remove(i);
    notifyListeners();
  }

  /// Clear all items from the stock.
  removeAll() {
    this._items.clear();
    notifyListeners();
  }

  sort() {
    this._items.sort((a,b) =>
        a.name.compareTo(b.name)
    );
    this._items.sort((a,b) =>
        b.essential.toString().compareTo(a.essential.toString())
    );
  }
}