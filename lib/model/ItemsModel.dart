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
  void increment(Item item) {
    getByItem(item).increment();
    notifyListeners();
  }

  /// Reset the count of an item by object reference.
  void reset(Item item) {
    getByItem(item).reset();
    notifyListeners();
  }

  /// Reset the count for the entire stock.
  void resetAll() {
    this._items.forEach((item) => item.reset() );
    notifyListeners();
  }

  /// Provide a new list of items.
  void set(List<Item> items){
    this.removeAll();
    items.forEach((item) => add(item) );
    notifyListeners();
  }

  /// Include an additional item to the stock.
  void add(Item item) {
    this._items.add(item);
    notifyListeners();
  }

  /// Remove an item from the stock
  void delete(Item i) {
    this._items.remove(i);
    notifyListeners();
  }

  /// Clear all items from the stock.
  void removeAll() {
    this._items.clear();
    notifyListeners();
  }
}