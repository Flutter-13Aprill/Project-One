import 'dart:io';
import 'package:my_first_project/my_first_project.dart';

void main() {
  bool continueLoop = true;
  print("Hi, Can you tell me what is your name?");
  String userName = stdin.readLineSync()!;
  print(
    "\n------------------------------------------------- Welcome $userName to our library --------------------------------------------------",
  );

  while (continueLoop) {
    print(
      "\nServices:\n1- View all books \n2- Add a new book \n3- Edit information for an existing book \n4- Searching for a book \n5- Delete a book \n6- Exit\n",
    );

    print("Please choose what do you want?");

    int? chosenOption;

    try {
      chosenOption = int.parse(stdin.readLineSync()!);
    } catch (e, s) {
      print("Error, please enter a valid number.");
      print("$s");
    }

    switch (chosenOption) {
      case 1:
        // View all books
        displayBooks();
      case 2:
        // Add a new book
        addBook();
      case 3:
        // Edit information for an existing book
        print("Please enter the book ID you want to edit");
        int? id;

        try {
          id = int.parse(stdin.readLineSync()!);
        } catch (e, s) {
          print("Error, please enter a valid number.");
          print("$s");
        }
        editBookInfo(id);
      case 4:
        // Searching for a book
        print(
          "Do you want to search by \n1- Book Title \n2- Book Author 3- \nBook category",
        );
        int? searchOption;
        try {
          searchOption = int.parse(stdin.readLineSync()!);
        } catch (e, s) {
          print("Error, please enter a valid number.");
          print("$s");
        }
        if (searchOption == 1) {
          searchByBookTitle();
        } else if (searchOption == 2) {
          searchByBookAuthor();
        } else if (searchOption == 3) {
          searchByBookCategory();
        } else {
          print("Please enter a valid number.");
        }

      case 5:
        // Delete a book
        print("Please enter the book ID you want to remove");
        int? id;
        try {
          id = int.parse(stdin.readLineSync()!);
        } catch (e, s) {
          print("Error, please enter a valid number.");
          print("$s");
        }
        removeBook(id);
      case 6:
        continueLoop = false;
        exit(0);
      default:
        print("Wrong!");
    }
  }
}
