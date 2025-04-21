
import 'dart:io';

import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/book.dart';

// Function to search for a book in the library
Future<void> searchForBook() async {
  // Check if there are no books in the library
  if (books.isEmpty) {
    print(
      getLocalizedMessage(
        "There are no books in the library.",
        "لا توجد كتب في المكتبة.",
      ),
    );
    return;
  }

  try {
    // Prompt the user to choose to search by author or title
    stdout.write(
      getLocalizedMessage(
        "Search by author (1) or title (2): ",
        "البحث عن طريق المؤلف (1) أو العنوان (2): ",
      ),
    );
    int choice = int.parse(stdin.readLineSync()!);
    // Prompt for the keyword to search
    stdout.write(
      getLocalizedMessage("Enter the keyword: ", "أدخل الكلمة المفتاحية: "),
    );
    String keyword = stdin.readLineSync()!.toLowerCase().trim();
    // Iterate through the list of books to find matches
    bool found = false;
    for (var book in books) {
      if ((choice == 1 && book.auther.toLowerCase().contains(keyword)) ||
          (choice == 2 && book.title.toLowerCase().contains(keyword))) {
        print(book.toString());
        found = true;
      }
    }
    // If no books were found, inform the user
    if (!found) {
      print(
        getLocalizedMessage(
          "No books found matching the keyword.",
          "لم يتم العثور على كتب تطابق الكلمة المفتاحية.",
        ),
      );
    }
  } catch (e) {
    // Print any error that occurs during the search
    print(e);
  }
}