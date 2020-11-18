import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/model/ItemsModel.dart';
import 'package:stock/widgets/BigButton.dart';

/// This displays the list of stock to the user.
class Stock extends StatelessWidget {
  // [ ] TODO add an edit button for each item on press and hold or slide left
  // [ ] TODO send the item to be edited through the Navigation function

  final String _title = 'Stock';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(this._title),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                      text: Provider.of<ItemsModel>(context).toList()));
                },
                child: Icon(Icons.share),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/new'),
                child: Icon(Icons.add),
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
              itemBuilder: (context, index) => listItem(context, index),
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

  /// A dismissible list item for an Item of stock
  Widget listItem(BuildContext context, int index) {
    Item item = Provider.of<ItemsModel>(context).get(index);
    return Dismissible(
      key: Key(item.name),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        Provider.of<ItemsModel>(context).delete(item);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('${item.name} removed from stock'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.yellow,
            onPressed: () => Provider.of<ItemsModel>(context).add(item),
          ),
        ));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.essential
              ? Colors.purpleAccent
              : Theme.of(context).secondaryHeaderColor,
          child: RichText(
              text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            text: '${item.count}',
            recognizer: LongPressGestureRecognizer()
              ..onLongPress =
                  () => Provider.of<ItemsModel>(context).reset(item),
          )),
        ),
        title: RichText(
            text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          text: '${item.name}',
          recognizer: TapGestureRecognizer()
            ..onTap = () => Provider.of<ItemsModel>(context).increment(item),
        )),
      ),
    );
  }
}
