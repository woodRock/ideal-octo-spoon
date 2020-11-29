import 'package:flutter/material.dart';

/// This component is for full screen buttons.
class BigButton extends StatelessWidget {
  final String _label;
  final Function _function;

  BigButton(this._label, this._function);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(this.label),
            onPressed: () => this.function.call(),
          ),
        ),
      ),
    );
  }

  /// Get the label for this button.
  String get label => this._label;

  /// Get the function for this button
  Function get function => this._function;
}
