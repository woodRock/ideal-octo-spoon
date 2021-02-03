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
class New extends StatefulWidget {
  @override
  _NewState createState() {
    return _NewState();
  }
}

/// The implementation for the item form, it requires the state defined above.
class _NewState extends State<New> {
  final String _title = 'New';
  final _formKey = GlobalKey<FormState>();
  final Item _item = Item.fromFactory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(this._title),
          actions: <Widget>[cancelButton(context)]),
      body: Builder(builder: (BuildContext context) {
        return itemForm(context);
      }),
    );
  }

  /// Returns to the stock list and discards the changes.
  Widget cancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/'),
      child: Icon(Icons.cancel),
    );
  }

  /// This form is used to add a new item to the stock.
  Widget itemForm(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Column(
        children: <Widget>[
          input(),
          BigButton('Submit', () => submit(context)),
        ],
      ),
    );
  }

  /// The user input fields for a new item. Centered in the middle of the screen.
  Widget input() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ItemTextFormField(
            'name',
            TextInputType.name,
            Icons.fastfood,
            this._item,
            (value) => _setName(value),
            context,
          ),
          ItemTextFormField(
            'count',
            TextInputType.number,
            Icons.bar_chart,
            this._item,
            (value) => _setCount(value),
            context,
          ),
          ItemTextFormField(
            'cost',
            TextInputType.number,
            Icons.attach_money,
            this._item,
            (value) => _setCost(value),
            context,
          ),
          toggle(),
        ],
      ),
    );
  }

  /// Toggle the priority for the item between need and want.
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
          labels: Item.labels,
          icons: [Icons.warning_outlined, Icons.attach_money],
          activeBgColors: [Colors.red, Colors.green],
          onToggle: (value) => _setEssential(value),
        ),
      ),
    );
  }

  /// Submit the current item from the form if its valid.
  void submit(BuildContext context) {
    if (!this._formKey.currentState.validate()) return;
    this._formKey.currentState.save();
    final int delay = 2;
    Provider.of<ItemsModel>(context).add(this._item);
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: delay),
        content: Text('Added to stock')));
    Timer(Duration(seconds: delay), () => Navigator.pushNamed(context, '/'));
  }

  _setName(String value) => this._item.name = value;

  _setCount(String value) => this._item.count = int.parse(value);

  _setCost(String value) => this._item.cost = double.parse(value);

  _setEssential(int value) => this._item.essential = value == 0;
}
