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

  ItemTextFormField(this.name, this.textInputType, this.icon, this.item,
      this.onSaved, this.context);

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Container(
      width: halfMediaWidth,
      child: TextFormField(
        keyboardType: textInputType,
        decoration: InputDecoration(icon: Icon(icon), labelText: name),
        validator: (value) => value.isEmpty ? 'Please enter the $name' : null,
        onSaved: (String value) => onSaved.call(value),
      ),
    );
  }
}
