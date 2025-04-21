import 'dart:io';

import 'package:manage_abook/manage_abook.dart';

List<Book> books = [];
int idBook = 0;
void main() {
  addListBook();
  while (true) {
    print('\n........******.......\n');
    print('::: WELCOME TO BOOK LIBRARY ::: \n');
    print('''
  [1] List all books
  [2] Add a new book
  [3] Edit a book
  [4] Search for a book
  [5] Delete a book
  [6] Sort
  [7] Exit
''');
    stdout.write("Enter your choice: ");
    int inputChoies = int.parse(stdin.readLineSync()!);

    switch (inputChoies) {
      case 1:
        listBooks();

        break;
      case 2:
        addBooks();
        break;
      case 3:
        editBook();
        break;
      case 4:
        searchBook();
        break;
      case 5:
        deleteBook();
        break;
      case 6:
        print('SORT: \n 1. Title \n 2. Genre \n 3. Year ');
        stdout.write('Enter your choice: ');
        int sortChoice = int.parse(stdin.readLineSync()!);
        if (sortChoice == 1) {
          sortBookTitle();
          listBooks();
        } else if (sortChoice == 2) {
          sortBookGenre();
          listBooks();
        } else if (sortChoice == 3) {
          sortBookYear();
          listBooks();
        } else {
          print('Invalid choice.');
        }

        break;
      case 7:
        print('Goodbye');
        return;
      default:
        print('Invalid choice, try again.');
    }
  }
}
