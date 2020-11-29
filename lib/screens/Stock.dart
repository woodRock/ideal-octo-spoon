import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock/model/ItemsModel.dart';
import 'package:stock/widgets/BigButton.dart';
import 'package:stock/widgets/ListItem.dart';

/// This displays the list of stock to the user.
class Stock extends StatelessWidget {
  final String _title = 'Stock';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // Don't display a back arrow on the home screen.
            automaticallyImplyLeading: false,
            title: Text(this._title),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Clipboard.setData(ClipboardData(
                    text: Provider.of<ItemsModel>(context).toList())),
                child: Icon(Icons.share),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/new'),
                child: Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                child: Icon(Icons.settings),
              ),
            ]),
        body: itemsPage(context));
  }

  /// Retrieves a list that is stored as a JSON in a local asset.
  Widget itemsPage(context) {
    return Column(children: [
      itemList(context),
      totalCost(context),
      BigButton('Load', () => Provider.of<ItemsModel>(context).loadAll()),
      BigButton('Save', () => Provider.of<ItemsModel>(context).save()),
    ]);
  }

  /// Displays the total cost of the stock
  Widget totalCost(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomAppBarColor,
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.headline5,
            children: <TextSpan>[
              TextSpan(
                  text: 'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: '${Provider.of<ItemsModel>(context).totalCost()}',
              )
            ]),
      ),
    );
  }

  /// A list of the items in the stock
  Widget itemList(BuildContext context) {
    final ItemsModel items = Provider.of<ItemsModel>(context);
    return Expanded(
      child: FutureBuilder(
        future: items.load(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ListItem(index),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
