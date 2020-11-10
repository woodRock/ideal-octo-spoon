class Item {

  String name;

  Item(this.name);

  Item.fromJSON(Map json) {
    this.name = json['name'];
  }

}