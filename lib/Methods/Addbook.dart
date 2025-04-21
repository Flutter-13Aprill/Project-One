


// Function to add a new book to the library
import 'dart:io';

import 'package:book/Methods/Book.dart';
import 'package:book/Methods/DisplayBooks.dart';
import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/Methods/UpdateBook.dart';
import 'package:book/book.dart';

Future<void> addbook() async {
  try {
    // Prompt for the details of the new book

    print(getLocalizedMessage("enter title of book", "ادخل اسم الكتاب"));
    String title = stdin.readLineSync()!.toLowerCase();
    print(getLocalizedMessage("enter author of book", "ادخل اسم المؤلف"));
    String author = stdin.readLineSync()!.toLowerCase();
    // Check if the book is already in the library
    if (isDoublcted(title, author)) {
      print(
        getLocalizedMessage("book alredy in library", "الكتاب موجود بالفعل"),
      );
      return;
    }
    print(getLocalizedMessage("enter  publication year", "ادخل تاريخ النشر "));
    String publicationyear = stdin.readLineSync()!.toLowerCase();
    print(
      getLocalizedMessage(
        "enter  categori year : Novel, History, Science",
        "ادخل نوع الكتاب  ",
      ),
    );
    String categori = stdin.readLineSync()!.toLowerCase();
    // Check if all required information is provided
    if (title.isNotEmpty &&
        author.isNotEmpty &&
        publicationyear.isNotEmpty &&
        categori.isNotEmpty) {
      books.add(Book(title, author, publicationyear, categori, countIdOfBook));
      countIdOfBook++;

      print(
        getLocalizedMessage(
          "the book add successfully",
          "تم اضافه الكتاب بنجاح",
        ),
      );
      await displayBooks(); // Display the updated list of books
    } else {
      // Inform the user if some information is missing
      print(
        getLocalizedMessage(
          "you doesnot enter all information of book",
          "لم تقم بادخال جميع معلومات الكتاب",
        ),
      );
      return;
    }
  } catch (e) {
    // Print any error that occurs during the addition
    print(e);
  }
}
