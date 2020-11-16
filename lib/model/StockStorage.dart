import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'Item.dart';

class StockStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/stock.json');
  }

  Future<List<Item>> readStock() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      List<dynamic> raw = jsonDecode(contents);
      return raw.map((f) => Item.fromJSON(f)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<File> writeStock(List<Item> stock) async {
    final file = await _localFile;
    final jsonString = jsonEncode(stock);
    return file.writeAsString(jsonString);
  }
}
