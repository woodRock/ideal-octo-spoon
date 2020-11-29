import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock/model/ItemsModel.dart';
import 'package:stock/model/ThemeModel.dart';
import 'package:stock/screens/Settings.dart';

import 'screens/New.dart';
import 'screens/Stock.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ItemsModel()),
      ChangeNotifierProvider(create: (_) => ThemeModel()),
    ],
    child: App(),
  ));
}

/// The root component of the application
/// * This handles the routing and themes for the entire application.
/// * Routes: top-level routes and their paths can be specified.
/// * Themes: we define the generic style guide for screens.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Provider.of<ThemeModel>(context).theme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Stock(),
        '/new': (context) => New(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
