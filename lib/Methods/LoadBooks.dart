
// Function to load books from a JSON file
import 'dart:convert';
import 'dart:io';

import 'package:book/Methods/Book.dart';
import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/book.dart';

Future<void> loadBooks() async {
  // Load the JSON file

  File file = File("books.json");
  try {
    // Check if the file exists
    if (file.existsSync()) {
      // Read the contents of the file as a string
      String jsonString = await file.readAsString();
      // Decode the JSON string into a list
      List<dynamic> listOfJison = jsonDecode(jsonString);
      // Convert each JSON object to a Book object and update the books list
      books = listOfJison.map((json) => Book.fromJson(json)).toList();
      // Set the next book ID based on the last book in the list
      countIdOfBook = books.isNotEmpty ? books.last.bookId + 1 : 0;
      // Print a message indicating that books were loaded successfully
      print(
        getLocalizedMessage(
          "Books loaded successfully.",
          "تم تحميل الكتب بنجاح.",
        ),
      );
    } else {
      print(getLocalizedMessage("library is empty", "المكتبة فارغة"));
    }
  } catch (e) {
    print("erorr i loading$e");
  }
}
