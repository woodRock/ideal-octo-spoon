import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO Implement context to store the items
    List items = ['Butter','Milk','Mince','Cheese'];
    return Scaffold(
        appBar: AppBar(
          title: Text('List')
        ),
        body: Column(
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
            RaisedButton(
              child: Text('Add'),
              onPressed: () => Navigator.pushNamed(context, '/add'),
            )
          ],
        )
    );
  }
}



