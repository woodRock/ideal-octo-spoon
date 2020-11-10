import 'package:flutter/material.dart';
import 'screens/Add.dart';
import 'screens/Stock.dart';

void main() {
  runApp(App());
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
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes : {
        '/': (context) => Stock(),
        '/add': (context) => Add(),
      },
    );
  }
}



