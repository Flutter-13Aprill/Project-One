import 'dart:convert';
import 'dart:io';
import 'book.dart';

class Storage {
  static const String filePath = 'books.json';

  static Future<List<Book>> loadBooks() async {
    final file = File(filePath);
    if (!file.existsSync()) return [];
    final jsonData = jsonDecode(await file.readAsString());
    return (jsonData as List).map((e) => Book.fromJson(e)).toList();
  }

  static Future<void> saveBooks(List<Book> books) async {
    final file = File(filePath);
    await file.writeAsString(jsonEncode(books.map((e) => e.toJson()).toList()));
  }
}
