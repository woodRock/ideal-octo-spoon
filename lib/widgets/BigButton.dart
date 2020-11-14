import 'package:flutter/material.dart';

/// This component is for full screen buttons.
/// * It is a generic component designed for re-use
/// * We provide the text, and action for the button.
class BigButton extends StatelessWidget {
  final String _text;
  final Function _action;

  /// Syntax sugar for the BigButton constructor.
  /// * Each BigButton takes text and an action
  /// * text: the label displayed on the button
  /// * action: a lambda function, the button calls when pressed.
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
