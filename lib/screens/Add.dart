import 'package:flutter/material.dart';
import 'package:stock/components/BigButton.dart';

/// This class adds an Item to the desired stock list.
/// * It is a form that updates the stock context.
class Add extends StatelessWidget {

  final String title = 'Add';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(this.title)
        ),
        body: getForm(context),
    );
  }

  Widget getForm(context) {
    return Column(
      children: [
        Expanded(
            child: Form(
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
            )
        ),
        BigButton('Cancel', () => Navigator.pushNamed(context, '/')),
      ],
    );
  }
}