/// This class captures the notion of an Item.
/// * It is the main object of our model for this application.
/// * We provide functionality to recreate an object from JSON.
class Item {

  String name;

  Item(this.name);

  /// This method recreates an Item from a JSON string.
  /// * We store our list with the asset of a JSON file.
  Item.fromJSON(Map json) {
    this.name = json['name'];
  }

}