


// Function to delete a book from the library
import 'dart:io';

import 'package:book/Methods/Book.dart';
import 'package:book/Methods/DisplayBooks.dart';
import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/book.dart';

Future<void> deleteBook() async {
  // Display the current list of books
  await displayBooks();
  try {
    // Prompt the user to enter the ID of the book they want to delete
    stdout.write(
      getLocalizedMessage(
        "Enter the ID of the book you want to delete: ",
        "أدخل معرف الكتاب الذي تريد حذفه: ",
      ),
    );
    // Read and parse the user input as an integer
    int id = int.parse(stdin.readLineSync()!);
    // Find the book to delete based on the provided ID
    Book? bookToDelete = books.firstWhere(
      (book) => book.bookId == id,
      orElse: () => Book("", "", "", "", -1),
    );
    // Check if the book was found
    if (bookToDelete.bookId == -1) {
      print(getLocalizedMessage("Book not found.", "الكتاب غير موجود."));
      return;
    } else {
      // Remove the book from the list
      books.remove(bookToDelete);
      print(
        getLocalizedMessage(
          "Book deleted successfully.",
          "تم حذف الكتاب بنجاح.",
        ),
      );
    }
  } catch (e) {
    // Print any error that occurs during the process
    print(e);
  }
}