import 'package:flutter/material.dart';
import 'ItemAdd.dart';
import 'ItemList.dart';

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
        '/': (context) => ItemList(),
        '/add': (context) => ItemAdd(),
      },
    );
  }
}


