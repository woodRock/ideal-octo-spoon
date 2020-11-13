import 'package:flutter/material.dart';
import 'package:stock/widgets/BigButton.dart';
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    icon: Icon(Icons.fastfood_sharp),
                    labelText: 'Name'),
                validator: (value) => value.isEmpty? 'Please enter the name' : null,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.bar_chart),
                    labelText: 'Count'
                ),
                validator: (value) => value.isEmpty? 'Please enter a count' : null,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    labelText: 'Cost'
                ),
                validator: (value) => value.isEmpty? 'Please enter the cost' : null,
              ),
              toggle(),
            ],
          )),
          submit(),
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
          initialLabelIndex: 0,
          cornerRadius: 20.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          labels: ['Need', 'Want'],
          icons: [Icons.warning_outlined, Icons.attach_money],
          activeBgColors: [Colors.red, Colors.green],
          onToggle: (int) => print('Switch'),
        ),
      ),
    );
  }

  /// Submit button displayed at the bottom of the page
  Widget submit() {
    return BigButton(
        'Submit',
            () => (_formKey.currentState.validate()) ?
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            content: Text('Added to stock')
        ))
            :
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          content: Text('Invalid Item'),
        ))
    );
  }
}