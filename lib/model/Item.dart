/// This class captures the notion of an Item.
class Item {
  String _name;
  int _count;
  bool _essential;
  double _cost;

  Item(this._name, this._count, this._essential, this._cost);

  /// This constructor is used for the New item form.
  /// Default state for an item is essential.
  Item.fromFactory() {
    this._essential = true;
  }

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

  set name(String name) => this._name = name;

  set count(int count) => this._count = count;

  set essential(bool essential) => this._essential = essential;

  set cost(double cost) => this._cost = cost;

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
