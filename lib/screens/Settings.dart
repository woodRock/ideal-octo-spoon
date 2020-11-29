import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/model/ThemeModel.dart';

// [ ] - TODO save the theme data into local storage.
/// Screen for the user to adjust the configuration for the application.
class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() {
    return _SettingsState();
  }
}

/// Returns the state for the settings screen.
class _SettingsState extends State<Settings> {
  final String _title = 'Settings';

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentColor;
  List<String> _colors = ['purple', 'red', 'blue'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this._title)),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Please choose your theme:"),
            Container(padding: EdgeInsets.all(16.0)),
            DropdownButton(
              value: _currentColor,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            )
          ],
        )),
      ),
    );
  }

  @override
  void initState() {
    this._dropDownMenuItems = this.getDropDownMenuItems();
    this._currentColor = this._dropDownMenuItems[0].value;
    super.initState();
  }

  /// Returns the drop down menu for each color.
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String color in this._colors) {
      items.add(DropdownMenuItem(value: color, child: Text(color)));
    }
    return items;
  }

  /// Updates the state of our widget by setting the chosen color.
  void changedDropDownItem(String selectedColor) {
    Provider.of<ThemeModel>(context).theme = this._toColor(selectedColor);
    setState(() {
      this._currentColor = selectedColor;
    });
  }

  /// Converts a string to a color value.
  _toColor(String color) {
    Map stringToColors = {
      "blue": Colors.blue,
      "purple": Colors.purple,
      "red": Colors.red
    };
    return stringToColors[color];
  }
}
