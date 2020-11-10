import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stock/components/BigButton.dart';
import 'package:stock/model/Item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// This displays the list of stock to the user.
/// * The state of each item can be adjusted on this screen.
/// * Items can be:
/// *   missing: not in the current stock,
/// *   in-stock: currently available,
/// *   essential: must be available,
/// *   luxury: not an essential item.
class Stock extends StatelessWidget {

  final String title = 'Stock';
  final String path = "assets/data/items.json";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title)
        ),
        body: getList(context)
    );
  }

  /// Retrieves a list that is stored as a JSON in a local asset.
  /// * We use a promise builder so different data sources can be substituded.
  /// * We check if the list has been loaded, if not we display a progress circle.
  /// * Otherwise, we display a list of slidable items based on future's snapshot.
  Widget getList(context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: getItems(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return getSlidable(snapshot.data[index]);
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ),
        BigButton('New', () => Navigator.pushNamed(context, '/new'))
      ],
    );
  }

  /// A slidable list item for an Item that has directional slide actions.
  /// * item: The item to be displayed as a slidable item on a list
  /// * Our slidable actions are primary and secondary, left -> right, right -> left.
  /// * Primary actions are very common, e.g., clear
  /// * Secondary actions are not common use cases, e.g., edit, delete
  ///
  /// TODO [ ] - Implement CRUD functionality with context.
  /// TODO [ ] - Add a total summary at the top (or bottom) of the page.
  Widget getSlidable(Item item) {
    return Slidable(
      actionExtentRatio: 0.25,
      actionPane: SlidableDrawerActionPane(),
      child: ListTile(
        leading: Icon(Icons.food_bank),
        title: Text('${item.name}'),
      ),
      actions: <Widget>[
        /// Resets the count for this item.
        IconSlideAction(
            caption: 'Clear',
            color: Colors.grey,
            icon: Icons.clear,
            onTap: () => print('Clear')
        )
      ],
      secondaryActions: <Widget>[
        /// Edit the information for an item.
        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () => print('Edit'),
        ),
        /// Remove an item from the list entirely.
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => print('Delete'),
        )
      ],
    );
  }

  /// Sorts a list of items alphabetically by name.
  List<Item> sortAlphabetically(List<Item> items) {
    items.sort((a,b) => a.name.compareTo(b.name));
    return items;
  }

  /// Retrieves a list of Items stored as a JSON as a local asset.
  /// * We must reference the asset in the pubspec.yaml.
  /// * The Item class has a constructor that takes JSON.
  Future<List<Item>> getItems(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString(this.path);
    List<dynamic> raw = jsonDecode(jsonString);
    List<Item> items = raw.map((f) => Item.fromJSON(f)).toList();
    return sortAlphabetically(items);
  }
}



