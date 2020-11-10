import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {

  String _text;
  Function _action;

  BigButton(this._text, this._action);

  String get text => this._text;
  Function get action => this._action;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(text),
            onPressed: () => action.call(),
          ),
        ),
      ),
    );
  }
}