import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:stock/model/ItemsModel.dart';
import 'package:stock/widgets/BigButton.dart';
import 'package:stock/model/Item.dart';
import 'package:stock/widgets/ItemTextFormField.dart';

/// A screen for adding a new item to the stock
class New extends StatelessWidget {

  final String _title = 'New';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._title),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            child: Icon(Icons.cancel),
          ),
        ]
      ),
      body: ItemForm(),
    );
  }
}

/// Returns the state for the item form.
class ItemForm extends StatefulWidget {

  @override
  ItemFormState createState() {
    return ItemFormState();
  }
}

/// The implementation for the item form, it requires the state defined above.
class ItemFormState extends State<ItemForm> {

  final _formKey = GlobalKey<FormState>();
  final Item _item = Item.fromFactory();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Column(
            children: [
              ItemTextFormField(
                'name',
                TextInputType.name,
                Icons.fastfood,
                this._item,
                (String value) => this._item.name = value,
                context,
              ),
              ItemTextFormField(
                'count',
                TextInputType.number,
                Icons.bar_chart,
                this._item,
                (String value) => this._item.count = int.parse(value),
                context,
              ),
              ItemTextFormField(
                'cost',
                TextInputType.number,
                Icons.attach_money,
                this._item,
                (String value) => this._item.cost = double.parse(value),
                context,
              ),
              toggle(),
            ],
          )),
          BigButton('submit', () => submit()),
        ],
      ),
    );
  }

  /// Toggle the priority for the item between need and want
  Widget toggle(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ToggleSwitch(
          minWidth: 90.0,
          initialLabelIndex: this._item.essential? 0 : 1,
          cornerRadius: 20.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          labels: ['Need', 'Want'],
          icons: [Icons.warning_outlined, Icons.attach_money],
          activeBgColors: [Colors.red, Colors.green],
          onToggle: (int value) => this._item.essential = value == 0,
        ),
      ),
    );
  }

  /// Submit the current item from the form if its valid
  void submit() {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      int delay = 2;
      Provider.of<ItemsModel>(context).add(this._item);
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: delay),
          content: Text('Added to stock')
      ));
      Timer(Duration(seconds: delay), () => Navigator.pushNamed(context, '/'));
    }
  }

}