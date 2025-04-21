import "dart:io" as io;

import "package:book_library/book.dart";
import "package:book_library/file_operation.dart";
import "package:book_library/translation_service.dart";

class BookManager with FileOperation {
  final TranslationService translator;
  late Book bookInfo;
  String fileName = "book_library.json";

  BookManager({required this.translator});

  //*help me to translate all app
  Future<String> textTranslate(String text) async {
    return await translator.translate(text);
  }

  //*This method responsible to display library option(book) to the user
  Future<int> displayMenu() async {
    int? choice;
    print(
      await textTranslate(
        "\nChoose what you want to do with your book library 📚:\n",
      ),
    );
    print(await textTranslate("1- Add a New Book "));
    print(await textTranslate("2- Delete a Book "));
    print(await textTranslate("3- Edit Book Details "));
    print(await textTranslate("4- Searching for a Book "));
    print(await textTranslate("5- Display All Books "));
    print(await textTranslate("6- Exit "));
    do {
      io.stdout.write(await textTranslate("\nEnter Your Choice: "));
      choice = int.parse(io.stdin.readLineSync()!);

      if (choice < 1 || choice > 6) {
        print(
          await textTranslate("Invalid choice,Please choose from the list"),
        );
      }
    } while (choice < 1 || choice > 6);
    return choice;
  }

  //* handling all operations related to book
  Future<void> startBookOperations() async {
    int userChoice = await displayMenu();

    switch (userChoice) {
      case 1:
        addBook();

      case 2:
        deleteBook();
        break;
      case 3:
        editBook();
        break;
      case 4:
        searchBook();
        break;
      case 5:
        displayAllBooks();
        break;
      case 6:
        print(
          "\nThank you for visiting my book library.\nSee you next time, bye👋",
        );
        io.exit(0);
    }
  }

  //* Add new book to json file(book_library.json)
  Future<void> addBook() async {
    print("\nAdd Book to the library:\n");

    //call jsonReader from Mixin Method to read (book_library.json)
    List<Map<String, dynamic>> existingBooks = await jsonReader(fileName);

    bool duplicate;

    do {
      duplicate = false;
      //User enter book information
      io.stdout.write("Enter Book Title: ");
      String? title = io.stdin.readLineSync()!;

      io.stdout.write("Enter Book Author: ");
      String? author = io.stdin.readLineSync()!;

      io.stdout.write("Enter Book Publisher: ");
      int? publisher = int.parse(io.stdin.readLineSync()!);

      //object from Book class
      bookInfo = Book(title, author, publisher);
      //to create id for the books
      int newId = 1;
      for (var book in existingBooks) {
        int currentId = book['id'];
        if (currentId >= newId) {
          newId = currentId + 1;
        }
        bookInfo.bookId = newId;
      }

      for (var book in existingBooks) {
        if (book['bookTitle'].toString().toLowerCase() == title.toLowerCase() &&
            book['authorName'].toString().toLowerCase() ==
                author.toLowerCase()) {
          print(
            "\nBook already exists in the library.\nPlease enter a different book.\n",
          );
          duplicate = true;
          break;
        }
      }
    } while (duplicate);

    //add book to existing books
    existingBooks.add(bookInfo.toJson());
    // call jsonWriter from Mixin Method to write on(book_library.json)
    await jsonWriter(fileName, existingBooks);

    print("\n✅ Book added successfully!");
    startBookOperations();
  }

  //*delete book from json file
  Future<void> deleteBook() async {
    displayAllBooks();
    //read from json file
    List<Map<String, dynamic>> books = await jsonReader(fileName);
    //Ask user to Enter the id of the book
    io.stdout.write('\nEnter the ID of the book you want to delete it: ');
    int? id = int.parse(io.stdin.readLineSync()!);

    //delate a book based on the id
    books.removeWhere((book) => book['id'] == id);

    //Restore the id
    for (var bookId in books) {
      bookId['id'] = books.indexOf(bookId) + 1;
    }

    //write in json file
    await jsonWriter(fileName, books);

    print("\nBook deleted successfully.");
    startBookOperations();
  }

  //*edit a book based on the id of book
  Future<void> editBook() async {
    displayAllBooks();

    List<Map<String, dynamic>> books = await jsonReader(fileName);
    io.stdout.write('\nEnter the ID of the book you want to edit it: ');
    int? id = int.parse(io.stdin.readLineSync()!);

    int? choice;
    Map<String, dynamic>? editBook;

    for (var bookId in books) {
      if (bookId['id'] == id) {
        editBook = bookId;
        print("What felid do you want to edit: ");
        print("1. Title");
        print("2. Author");
        print("3. Year");
        print("4. All");
        io.stdout.write("\nEnter Your Choice: ");
        choice = int.parse(io.stdin.readLineSync()!);
      }
    }
    print(editBook);
    switch (choice) {
      case 1:
        io.stdout.write('\nEnter the new title: ');
        String? title = io.stdin.readLineSync();
        editBook!['bookTitle'] = title;

      case 2:
        io.stdout.write('\nEnter the new author: ');
        String? author = io.stdin.readLineSync();
        editBook!['authorName'] = author;

      case 3:
        io.stdout.write('\nEnter the new Year: ');
        int? year = int.parse(io.stdin.readLineSync()!);
        editBook!['publicationYear'] = year;
      case 4:
        io.stdout.write('\nEnter the new title: ');
        String? title = io.stdin.readLineSync();
        editBook!['bookTitle'] = title;
        io.stdout.write('\nEnter the new author: ');
        String? author = io.stdin.readLineSync();
        editBook['authorName'] = author;
        io.stdout.write('\nEnter the new Year: ');
        int? year = int.parse(io.stdin.readLineSync()!);
        editBook['publicationYear'] = year;
    }

    await jsonWriter(fileName, books);

    print("\nBook updated successfully!");
    startBookOperations();
  }

  //*search for a book based on the book/author name
  Future<void> searchBook() async {
    //read from json file
    List<Map<String, dynamic>> books = await jsonReader(fileName);
    //Ask user to Enter the title of the book
    io.stdout.write("\nSearch for a book by enter book name: ");
    String? title = io.stdin.readLineSync();
    //Search a book based on the title
    for (var name in books) {
      if (name['bookTitle'].toString().toLowerCase().contains(
            title!.toLowerCase(),
          ) ||
          name['authorName'].toString().toLowerCase().contains(
            title.toLowerCase(),
          )) {
        print("\nAll Books Found it :");
        print("\n📚 Book Found:");
        name.forEach((key, value) {
          print("$key: $value");
        });
      }
    }
    startBookOperations();
  }

  //*display AllBooks
  Future<void> displayAllBooks() async {
    print("\nDisplay All Books:\n");
    List<Map<String, dynamic>> bookData = await jsonReader('book_library.json');
    bookData.sort(
      (title1, title2) => title1['bookTitle']
          .toString()
          .toLowerCase()
          .compareTo(title2['bookTitle'].toString().toLowerCase()),
    );

    for (var book in bookData) {
      print("\n📚 Book:\n");
      book.forEach((key, value) {
        print("$key: $value");
      });
    }
    startBookOperations();
  }
}
