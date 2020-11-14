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
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Form(
      key: this._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Column(
            children: [
              Container(
                width: halfMediaWidth,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: Icon(Icons.fastfood_sharp),
                      labelText: 'Name'),
                  validator: (value) => value.isEmpty? 'Please enter the name' : null,
                  onSaved: (String value) => _item.name = value,
                ),
              ),
              Container(
                width: halfMediaWidth,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.bar_chart),
                      labelText: 'Count'
                  ),
                  validator: (value) => value.isEmpty? 'Please enter a count' : null,
                  onSaved: (String value) => this._item.count = int.parse(value),
                ),
              ),
              Container(
                width: halfMediaWidth,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.attach_money),
                      labelText: 'Cost'
                  ),
                  validator: (value) => value.isEmpty? 'Please enter the cost' : null,
                  onSaved: (String value) => this._item.cost = double.parse(value),
                ),
              ),
              toggle(this._item),
            ],
          )),
          submit(this._item),
        ],
      ),
    );
  }

  /// Toggle the priority for the item between need and want
  Widget toggle(Item item){
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
          onToggle: (int value) => item.essential = value == 0,
        ),
      ),
    );
  }

  /// Submit button displayed at the bottom of the page
  Widget submit(Item item) {
    return BigButton(
      'Submit',
      () {
        if (this._formKey.currentState.validate()) {
          this._formKey.currentState.save();
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              content: Text('Added to stock')
          ));
          Provider.of<ItemsModel>(context).add(item);
        }
      }
    );
  }

}