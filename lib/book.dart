import 'dart:io';
import 'dart:convert';
import 'package:book/Methods/Addbook.dart';
import 'package:book/Methods/DeleteBook.dart';
import 'package:book/Methods/DisplayBooks.dart';
import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/Methods/SearchForBook.dart';
import 'package:book/Methods/SetLanguage.dart';
import 'package:book/Methods/UpdateBook.dart';
import 'package:book/Methods/loadBooks.dart';
import 'package:book/Methods/saveBooks.dart';

import 'Methods/Book.dart';

// List to store books that will be added by the user and loaded from a JSON file
List<Book> books = [];
// Variable to track the unique ID for each book
int countIdOfBook = 0;
// Variable to determine the language used
bool isEnglish = true;


//start of thee program
void startProgram() async {
  // Load books from the JSON file when the program starts
  await loadBooks();
  // Set the language for the program
  setLanguage();
  while (true) {
    // Display the menu options to the user
    print(
      getLocalizedMessage(
        "1.Displaying books in the library ",
        "اعرض الكتب الموجوده بالمكتبه",
      ),
    );
    print(getLocalizedMessage("2.Adding a new book", "اضف كتاب جديد"));
    print(getLocalizedMessage("3.update book", "عدل الكتب "));
    print(
      getLocalizedMessage(
        "4.Searching for a book using a keyword title or author name",
        "ابحث عن كتاب بإستخدام اختصار اسم الكتاب او المؤلف",
      ),
    );
    print(
      getLocalizedMessage(
        "5.Deleting a book from the library",
        "احذف كتاب من المكتبه ",
      ),
    );
    print(getLocalizedMessage("6.enter exit to exit", "اكتب خروج للخروج "));
    try {
      // Get user input and go to the method that mtch this choise
      int userAction = int.parse(stdin.readLineSync()!);
      //user choise 1 will go to displayBooks
      if (userAction == 1) {
        await displayBooks();
      } else if (userAction == 2) {
        //user choise 2 will go to add book and save update  it on json
        await addbook();
        await saveBooks();
      } else if (userAction == 3) {
        //user choise 3 will go to update Book and save  update  it on json
        await updateBook();
        await saveBooks();
      } else if (userAction == 4) {
        //user choise 4 will go to search Book and
        searchForBook();
      } else if (userAction == 5) {
        //user choise 4 will go to delete Book and save update  it on json
        await deleteBook();
        await saveBooks();
      } else if (userAction == 6) {
        // Check if the user wants to exit the program
        await saveBooks();
        exit(0);
      } else {
        // if user choice none of the above print
        print(
          getLocalizedMessage(
            "you shuold choose from list",
            "يجب الاختيار من القائمه",
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
