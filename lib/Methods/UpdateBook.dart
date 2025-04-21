

// Function to update the details of a book
import 'dart:io';

import 'package:book/Methods/Book.dart';
import 'package:book/Methods/DisplayBooks.dart';
import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/book.dart';

Future<void> updateBook() async {
  // Display the current list of books
  await displayBooks();
  try {
    // Prompt the user to press enter to skip editing
    print(
      getLocalizedMessage(
        "press enter to skip edit ",
        "اضغط زر الادخال لعدم التغيير ",
      ),
    );
    // Prompt for the book ID to update
    print(getLocalizedMessage("enter book id", "ادخل الرقم التسلسلي "));
    int idOfBook = int.parse(stdin.readLineSync()!);
    // Find the book to edit based on the provided ID
    Book? bookToEdit = books.firstWhere((book) => book.bookId == idOfBook);
    // Update the book details if they are provided
    if (bookToEdit == null) {
      print(getLocalizedMessage("the book is not exit", "الكتاب غير موجود"));
      return;
    }
    // Prompt for the new details of the book
    print(getLocalizedMessage("enter title of book", "ادخل اسم الكتاب"));
    String? title = stdin.readLineSync();
    print(getLocalizedMessage("enter author of book", "ادخل اسم المؤلف"));
    String? author = stdin.readLineSync();
    String? publicationyear = stdin.readLineSync();
    print(getLocalizedMessage("enter  categori year", "ادخل نوع الكتاب  "));
    String? categori = stdin.readLineSync();
    // if user enter new value will update the details
    if (title != null) {
      bookToEdit.title = title.toLowerCase();
    }
    if (author != null) {
      bookToEdit.auther = author.toLowerCase();
    }
    if (publicationyear != null) {
      bookToEdit.publicationYear = publicationyear.toLowerCase();
    }
    if (categori != null) {
      bookToEdit.categories = categori.toLowerCase();
    }
  } catch (e) {
    // Print any error that occurs during the update
    print(e);
  }
}

// Function to check for duplicate books based on title and author
bool isDoublcted(String title, String author) {
  // Use any() to check if the list already contains the book
  return books.any((book) => book.title == title && book.auther == author);
}