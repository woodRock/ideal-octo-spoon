import 'package:flutter/material.dart';
import 'package:stock/model/Item.dart';

/// These are used as the input fields for the item input text fields.
class ItemTextFormField extends StatelessWidget {
  final String name;
  final TextInputType textInputType;
  final IconData icon;
  final Item item;
  final Function onSaved;
  final BuildContext context;
  final String initial;

  /// Constructor for the ItemTextFormField.
  ItemTextFormField(this.name, this.textInputType, this.icon, this.item,
      this.onSaved, this.context,
      {this.initial});

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Container(
      width: halfMediaWidth,
      child: TextFormField(
        keyboardType: textInputType,
        decoration: InputDecoration(icon: Icon(icon), labelText: name),
        validator: (value) => _validator(value),
        onSaved: (String value) => onSaved.call(value),
        initialValue: this.initial != null ? this.initial : '',
      ),
    );
  }

  /// Wrapper method to select the validator.
  dynamic _validator(String value) {
    if (this.textInputType == TextInputType.number)
      return numericValidator(value);
    return emptyValidator(value);
  }

  /// Validator to check if a string is numeric.
  dynamic numericValidator(String value) =>
      isNumeric(value) ? null : '$name must be a number';

  /// Validator to check for an empty string.
  dynamic emptyValidator(String value) =>
      value.isEmpty ? 'Please enter the $name' : null;

  /// Returns true if string is numeric, false otherwise.
  bool isNumeric(String s) {
    if (s == null) return false;
    return double.tryParse(s) != null;
  }
}
