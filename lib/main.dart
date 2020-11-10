import 'package:flutter/material.dart';
import 'screens/Add.dart';
import 'screens/Stock.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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



