import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/model/ItemsModel.dart';
import 'package:stock/widgets/BigButton.dart';
import 'package:stock/widgets/ItemTextFormField.dart';
import 'package:toggle_switch/toggle_switch.dart';

// TODO [ ] - Refactor a generic form class.
// TODO       This extracts duplicate code from the New and Edit screens.

/// A screen for adding a new item to the stock
class Edit extends StatefulWidget {
  final Item _item;

  /// Creates a form to edit an existing item from the stock.
  /// * _item: the item to be edited, which fills initial values.
  Edit(this._item);

  @override
  _EditState createState() {
    return _EditState(this._item, this._item);
  }
}

/// The implementation for the item form, it requires the state defined above.
class _EditState extends State<Edit> {
  final String _title = 'Edit';
  final _formKey = GlobalKey<FormState>();
  final Item _item;
  final Item _original;

  /// Pass the item twice to make a copy for book keeping.
  _EditState(this._item, this._original);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this._title), actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            // The item original item must be added back to the stock.
            // As it is removed by the dismissible in opening this screen.
            Provider.of<ItemsModel>(context).add(this._original);
            Navigator.pushNamed(context, '/');
          },
          child: Icon(Icons.cancel),
        ),
      ]),
      body: form(context, this._item),
    );
  }

  Widget form(BuildContext context, Item item) {
    return Form(
      key: this._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Column(
            children: [
              ItemTextFormField(
                'name',
                TextInputType.name,
                Icons.fastfood,
                this._item,
                (value) => _setName(value),
                context,
                initial: this._item.name,
              ),
              ItemTextFormField(
                'count',
                TextInputType.number,
                Icons.bar_chart,
                this._item,
                (value) => _setCount(value),
                context,
                initial: this._item.count.toString(),
              ),
              ItemTextFormField(
                'cost',
                TextInputType.number,
                Icons.attach_money,
                this._item,
                (value) => _setCost(value),
                context,
                initial: this._item.cost.toString(),
              ),
              toggle(),
            ],
          )),
          BigButton('Submit', () => submit()),
        ],
      ),
    );
  }

  /// Toggle the priority for the item between need and want
  Widget toggle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ToggleSwitch(
          minWidth: 90.0,
          initialLabelIndex: this._item.essential ? 0 : 1,
          cornerRadius: 20.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          labels: ['Need', 'Want'],
          icons: [Icons.warning_outlined, Icons.attach_money],
          activeBgColors: [Colors.red, Colors.green],
          onToggle: (value) => _setEssential(value),
        ),
      ),
    );
  }

  /// Submit the current item from the form if its valid
  void submit() {
    if (!this._formKey.currentState.validate()) return;
    this._formKey.currentState.save();
    int delay = 2;
    Provider.of<ItemsModel>(context).add(this._item);
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: delay),
        content: Text('Edited item from stock')));
    Timer(Duration(seconds: delay), () => Navigator.pushNamed(context, '/'));
  }

  /// Sets the name for item.
  _setName(String value) => this._item.name = value;

  /// Set the count for the item.
  _setCount(String value) => this._item.count = int.parse(value);

  /// Set the cost for the item.
  _setCost(String value) => this._item.cost = double.parse(value);

  /// Set the necessity of an item.
  _setEssential(int value) => this._item.essential = value == 0;
}
