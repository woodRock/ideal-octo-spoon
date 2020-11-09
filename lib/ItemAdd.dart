import 'package:flutter/material.dart';

class ItemAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
            title: Text('Add')
        ),
        body: Column(
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
            RaisedButton(
                child: Text('Back'),
                onPressed: () => Navigator.pushNamed(context, '/'),
            )
          ],
        )
    );
  }
}