import 'dart:io' as io;
import 'dart:io';
import 'package:project1/project1.dart';

class Book {
  String? title;
  String? authorName;
  int? year;

  Book(this.title, this.authorName, this.year); //constructor

  String toString() {
    //function to convert objects to text

    return '$title,$authorName,$year';
  }

  static Book fromString(String line) {
    //function to convert String to object(book)

    List<String> parts = line.split(','); //to split the list
    return Book(parts[0], parts[1], int.tryParse(parts[2]) ?? 0);
  }

  String? getTitle() {
    return title;
  }

  void setTitle(String title) {
    this.title = title;
  }

  String? getAuthorName() {
    return authorName;
  }

  void setAuthorName(String authorName) {
    this.authorName = authorName;
  }

  int? getYear() {
    return year;
  }

  void setYear(String? year) {
    this.year = year as int?;
  }
}

class Library {
  //class to store list of the books

  late List<Book> books;

  Library() {
    //consturctor

    books = <Book>[]; //list to store the books
  }

  void addBook(Book book) {
    //method to add a book
    books.add(book);
    saveBookToFile(book); //to save book to the file
  }

  void removeBook(Book book) {
    //method to remove a book

    books.remove(book);
  }

  List<Book> getBooks() {
    //method to get the list of the books

    return books;
  }

  void loadBooksFromFile() {
    //load function
    File file = File('books.txt'); //object to read the file
    if (file.existsSync()) {
      //check if the file exist

      List<String> lines =
          file.readAsLinesSync(); //list to store every lines(one book)

      for (var line in lines) {
        //loop to convert every line to object(Book)
        books.add(Book.fromString(line));
      }
    }
  }

  void saveBookToFile(Book book) {
    //save function

    File file = File('books.txt');

    file.writeAsStringSync(
      '${book.toString()}\n',
      mode: FileMode.append,
    ); //to save new book without deleting
  }
}

void main() {
  Library library = new Library(); //create an object

  library.loadBooksFromFile();

  print("Hello, what do you want to do?");
  print("1: Show the list of books.");
  print("2: Adding a book.");
  print("3: Removing a book.");
  int? Choose = int.tryParse(io.stdin.readLineSync() ?? "");

  if (Choose == 1) {
    print("List of books");
    for (Book book in library.getBooks()) {
      print('${book.getTitle()} - ${book.getAuthorName()} (${book.getYear()})');
    }
  } else if (Choose == 2) {
    print(
      "Please provide me with the name of the book, the author name and the year.",
    );
    while (true) {
      String title = io.stdin.readLineSync() ?? "";
      String author = io.stdin.readLineSync() ?? "";
      int year = int.tryParse(io.stdin.readLineSync() ?? '') ?? 2000;

      library.addBook(Book(title, author, year));

      break;
    }
  } else {
    while (true) {
      String title = io.stdin.readLineSync() ?? "";
      String author = io.stdin.readLineSync() ?? "";
      int year = int.tryParse(io.stdin.readLineSync() ?? '') ?? 2000;
      library.removeBook(Book(title, author, year));

      break;
    }
  }
}
