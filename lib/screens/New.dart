import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/model/ItemsModel.dart';
import 'package:stock/widgets/BigButton.dart';
import 'package:stock/model/Item.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
              itemTextFormField(
                name: 'name',
                textInputType: TextInputType.name,
                icon: Icons.fastfood,
                item: this._item,
                onSaved: (String value) => this._item.name = value,
              ),
              itemTextFormField(
                name: 'count',
                textInputType: TextInputType.number,
                icon: Icons.bar_chart,
                item: this._item,
                onSaved: (String value) => this._item.count = int.parse(value),
              ),
              itemTextFormField(
                name: 'cost',
                textInputType: TextInputType.number,
                icon: Icons.attach_money,
                item: this._item,
                onSaved: (String value) => this._item.cost = double.parse(value),
              ),
              toggle(),
            ],
          )),
          submit(),
        ],
      ),
    );
  }

  Widget itemTextFormField({String name, TextInputType textInputType, IconData icon, Item item, Function onSaved}) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Container(
      width: halfMediaWidth,
      child: TextFormField(
        keyboardType: textInputType,
        decoration: InputDecoration(
            icon: Icon(icon),
            labelText: name),
        validator: (value) => value.isEmpty? 'Please enter the $name' : null,
        onSaved: (String value) => onSaved.call(value),
      ),
    );
  }

  /// Toggle the priority for the item between need and want
  Widget toggle(){
    this._item.essential = true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ToggleSwitch(
          minWidth: 90.0,
          initialLabelIndex: 0,
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

  /// Submit button displayed at the bottom of the page
  Widget submit() {
    return BigButton(
      'Submit',
      () {
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
    );
  }

}