import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {

  String text;
  Function action;

  BigButton(this.text, this.action);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(this.text),
            onPressed: () => this.action.call(),
          ),
        ),
      ),
    );
  }
}