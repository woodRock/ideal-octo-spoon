import 'package:flutter/material.dart';
import 'package:stock/model/Item.dart';

/// These are used as the input fields for the item input text fields.
Widget itemTextFormField({
  String name,
  TextInputType textInputType,
  IconData icon,
  Item item,
  Function onSaved,
  BuildContext context}
  ) {
  final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
  return Container(
    width: halfMediaWidth,
    child: TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
          icon: Icon(icon),
          labelText: name),
      validator: (value) => value.isEmpty? 'Please enter the $name' : null,
      onSaved: (String value) => onSaved.call(value),
    ),
  );
}