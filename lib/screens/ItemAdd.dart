import 'package:flutter/material.dart';
import 'package:stock/components/BigButton.dart';

class ItemAdd extends StatelessWidget {

  final String title = 'Add';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
            title: Text(this.title)
        ),
        body: getForm(context, _formKey),
    );
  }

  Widget getForm(context, _formKey) {
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
        BigButton('Back', () => Navigator.pushNamed(context, '/')),
      ],
    );
  }
}