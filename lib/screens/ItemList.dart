import 'package:flutter/material.dart';
import 'package:stock/components/BigButton.dart';

class ItemList extends StatelessWidget {

  final String title = 'List';
  final List _items = ['Butter','Milk','Mince','Cheese'];

  List getItems() {
    return this._items;
  }

  @override
  Widget build(BuildContext context) {
    // TODO Implement context to store the items
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title)
        ),
        body: getList(context)
    );
  }

  Widget getList(context) {
    List items = getItems();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: Icon(Icons.emoji_food_beverage),
                  title : Text('${items[index]}')
              );
            },
          ),
        ),
        BigButton('Add', () => Navigator.pushNamed(context, '/add'))
      ],
    );
  }
}



