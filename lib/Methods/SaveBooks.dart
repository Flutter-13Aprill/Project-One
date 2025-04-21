
// Function to save books to a JSON file
import 'dart:convert';
import 'dart:io';
import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/book.dart';

Future<void> saveBooks() async {
  // Load the JSON file
  File file = File('books.json');
  try {
    // Encode the books as JSON and convert to a list
    String jsonString = jsonEncode(books.map((book) => book.toJson()).toList());
    // Write the JSON string to the file
    await file.writeAsString(jsonString);
    // Print a message indicating that the books were saved successfully
    print(
      getLocalizedMessage("Books saved successfully.", "تم حفظ الكتب بنجاح."),
    );
  } catch (e) {
    // if the error arise it will print it
    print(
      getLocalizedMessage("Error saving books: $e", "خطأ في حفظ الكتب: $e"),
    );
    print(e);
  }
}
