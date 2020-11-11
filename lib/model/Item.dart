/// This class captures the notion of an Item.
class Item {

  String _name;
  int _count;
  bool _essential;
  double _cost;

  /// This method recreates an Item from a JSON string.
  /// * We store our list with the asset of a JSON file.
  Item.fromJSON(Map json) {
    this._name = json['name'];
    this._count = json['count'];
    this._essential = json['essential'];
    this._cost = json['cost'];
  }

  String get name => this._name;
  int get count => this._count;
  bool get essential => this._essential;
  double get cost => this._cost;

  /// Sets the count for this item to zero.
  reset() {
    this._count = 0;
  }

  /// Increases the count for this item by one.
  increment() {
    this._count++;
  }

  /// Calculates the cost for the quantity of this item.
  double totalCost() {
    return this._cost * this._count;
  }

}