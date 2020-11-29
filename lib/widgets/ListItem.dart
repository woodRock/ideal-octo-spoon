import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/model/ItemsModel.dart';
import 'package:stock/model/ThemeModel.dart';
import 'package:stock/screens/Edit.dart';

/// A dismissible list item for an Item of stock
class ListItem extends StatelessWidget {
  final int _index;

  ListItem(this._index);

  @override
  Widget build(BuildContext context) {
    Item item = Provider.of<ItemsModel>(context).get(this._index);
    return Dismissible(
      key: Key(item.name),
      background: Container(
        color: Colors.green,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerStart,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        switch (direction) {
          case DismissDirection.startToEnd:
            {
              Item ref = item;
              Provider.of<ItemsModel>(context).delete(item);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Edit(ref)));
            }
            break;
          case DismissDirection.endToStart:
            {
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
            }
            break;
          default:
            break;
        }
      },
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: item.essential
                ? Provider.of<ThemeModel>(context).theme
                : Theme.of(context).secondaryHeaderColor,
            child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    text: '${item.count}',
                    recognizer: LongPressGestureRecognizer()
                      ..onLongPress =
                          () => Provider.of<ItemsModel>(context).reset(item)))),
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
