import 'package:flutter/material.dart';
import 'package:stock/widgets/BigButton.dart';

/// This class adds an Item to the desired stock list.
class New extends StatelessWidget {

  final String _title = 'New';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(this._title)
        ),
        body: page(context),
    );
  }

  /// Page with a form and cancel button.
  /// TODO [ ] - check for duplicate Items that have already been added in validator
  Widget page(context) {
    return Column(
      children: [
        Expanded(
            child: getForm(context),
        ),
        BigButton('Cancel', () => Navigator.pushNamed(context, '/')),
      ],
    );
  }

  /// A form to add a New item to the stock list.
  Widget getForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Item name'
              ),
              validator: (value) {
                return (value.isEmpty)? 'Please a name' : null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            )
          ],
        )
    );
  }
}