import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stock/components/BigButton.dart';
import 'package:stock/model/Item.dart';

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
                      return ListTile(
                        leading: Icon(Icons.food_bank),
                        title: Text('${snapshot.data[index].name}')
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ),
        BigButton('Add', () => Navigator.pushNamed(context, '/add'))
      ],
    );
  }

  List<Item> sortAlphabetically(List<Item> items) {
    items.sort((a,b) => a.name.compareTo(b.name));
    return items;
  }

  Future<List<Item>> getItems(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString(this.path);
    List<dynamic> raw = jsonDecode(jsonString);
    List<Item> items = raw.map((f) => Item.fromJSON(f)).toList();
    return sortAlphabetically(items);
  }
}



