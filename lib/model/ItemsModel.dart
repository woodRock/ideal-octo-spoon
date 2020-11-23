import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/model/StockStorage.dart';

/// This bloc stores the state of the items.
class ItemsModel extends ChangeNotifier {
  StockStorage storage;
  final List<Item> _items = [];

  ItemsModel() {
    this.storage = StockStorage();
  }

  /// Returns an unmodifiable list of items for public use.
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
    return roundDouble(sum, 2);
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
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
    this._items.forEach((item) => item.reset());
    notifyListeners();
  }

  /// Provide a new list of items.
  set(List<Item> items) {
    this.removeAll();
    items.forEach((item) => add(item));
    this._sort();
    notifyListeners();
  }

  /// Include an additional item to the stock.
  add(Item item) {
    this._items.add(item);
    this._sort();
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

  /// Sort by priority then alphabetically by name
  _sort() {
    this._items.sort((a, b) => a.name.compareTo(b.name));
    this._items.sort(
        (a, b) => b.essential.toString().compareTo(a.essential.toString()));
  }

  /// Saves the items in the current stock to local storage.
  void save() {
    this.storage.writeStock(this.items);
  }

  /// Retrieves a list of Items stored as a JSON in local storage.
  Future<List<Item>> load() async {
    return this.storage.readStock();
  }

  /// Loads the stock from local storage and sets it to the current stock.
  void loadAll() async {
    List<Item> items = await load();
    set(items);
  }

  /// Returns the stock as a list with count for each item in markdown format.
  String toList() {
    String res = '${dateToday()}\n---\n';
    this.items.forEach((item) => res += item.toString());
    return res;
  }

  /// Returns the current date in the ISO date standard.
  static String dateToday() {
    return new DateFormat('yyyy-MM-dd').format(new DateTime.now());
  }
}
