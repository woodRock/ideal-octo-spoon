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
            automaticallyImplyLeading: false,
            title: Text(this._title),
            actions: actions(context)),
        body: itemsPage(context));
  }

  /// The following are actions for the stock page AppBar:
  /// * share: copies the list to the clipboard.
  /// * new: adds a new item the stock.
  /// * settings: navigates to the settings page.
  List<Widget> actions(BuildContext context) {
    return [
      ElevatedButton(
        onPressed: () => Clipboard.setData(
            ClipboardData(text: Provider.of<ItemsModel>(context).toList())),
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
    ];
  }

  /// The content for the widget (everything accept the AppBar).
  Widget itemsPage(BuildContext context) {
    return Column(children: [
      itemList(context),
      totalCost(context),
      BigButton('Load', () => Provider.of<ItemsModel>(context).loadAll()),
      BigButton('Save', () => Provider.of<ItemsModel>(context).save()),
    ]);
  }

  /// A list of the items in the stock.
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

  /// Displays the total cost of the stock.
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
}
