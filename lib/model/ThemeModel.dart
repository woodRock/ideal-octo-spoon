import 'package:flutter/material.dart';

/// Stores the theme color for the application, which can be set on the settings screen.
class ThemeModel extends ChangeNotifier {
  static final Color defaultColor = Colors.purple;
  Color _theme = Colors.purple;

  ThemeModel() {
    this._theme = defaultColor;
  }

  set theme(Color c) {
    this._theme = c;
    notifyListeners();
  }

  get theme => this._theme;
}
