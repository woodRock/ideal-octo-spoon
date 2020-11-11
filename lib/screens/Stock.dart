import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/widgets/BigButton.dart';
import 'package:stock/model/Item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock/model/ItemsModel.dart';

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
            automaticallyImplyLeading: false,
            title: Text(this.title),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/new'),
                child: Icon(Icons.add),
              )
            ]
        ),
        body: items(context)
    );
  }

  /// Retrieves a list that is stored as a JSON in a local asset.
  Widget items(context) {
    final ItemsModel items = Provider.of<ItemsModel>(context);
    return Column(
      children: [
        itemList(context),
        totalCost(context),
        BigButton('Calculate', () => print("Calculate")),
        BigButton('Reset', () => items.resetAll() ),
      ]
    );
  }

  /// A list of the items in the stock
  Widget itemList(BuildContext context) {
    final ItemsModel items = Provider.of<ItemsModel>(context);
    return Expanded(
      child: FutureBuilder(
        future: getItems(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (items.length == 0)
              items.set(snapshot.data);
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => slidableItem(context, index),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );

  }

  /// Displays the total cost of the stock
  Widget totalCost(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.headline5,
            children: <TextSpan>[
              TextSpan(
                  text: 'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),
              TextSpan(
                text: '${Provider.of<ItemsModel>(context).totalCost()}',
              )
            ]
        ) ,
      ),
    );
  }

  /// A slidable list item for an Item that has directional slide actions.
  Widget slidableItem(BuildContext context, int index) {
    Item item = Provider.of<ItemsModel>(context).get(index);
    return Slidable(
      actionExtentRatio: 0.25,
      actionPane: SlidableDrawerActionPane(),
      child: ListTile(
        leading: CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: item.essential? Colors.amber : Colors.greenAccent,
          child: Text('${item.count}'),
        ),
        title: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            text: '${item.name}',
            recognizer: new TapGestureRecognizer()..onTap = () => Provider.of<ItemsModel>(context).increment(item),
          ),
        )
      ),
      actions: <Widget>[
        IconSlideAction(
            caption: 'Clear',
            color: Colors.grey,
            icon: Icons.clear,
            onTap: () => Provider.of<ItemsModel>(context).reset(item),
        )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () => print('Edit'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => Provider.of<ItemsModel>(context).delete(item),
        )
      ],
    );
  }

  /// Sorts a list of items into display order.
  List<Item> sortItems(List<Item> items) {
    items.sort((a,b) =>
        a.name.compareTo(b.name)
    );
    items.sort((a,b) =>
        b.essential.toString().compareTo(a.essential.toString())
    );
    return items;
  }

  /// Retrieves a list of Items stored as a JSON as a local asset.
  Future<List<Item>> getItems(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString(this.path);
    // dynamic is the like the Any type from Typescript
    List<dynamic> raw = jsonDecode(jsonString);
    List<Item> items = raw.map((f) => Item.fromJSON(f)).toList();
    return sortItems(items);
  }
}



