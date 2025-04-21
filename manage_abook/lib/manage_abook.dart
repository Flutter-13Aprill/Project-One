import 'dart:io';

List<Book> books = [];
int idBook = 0;

// A class that represents a book with title, author, and year published.
class Book {
  String? title;
  String? author;
  int? year;
  int? id;
  String? genre;

  Book(this.id, this.title, this.author, this.year, this.genre);

  display() {
    print(
      'ID: $id . Title: $title. Author: $author. Year: $year. Genre: $genre',
    );
  }
}

// A list to store all the books
void listBooks() {
  if (books.isEmpty) {
    print('No books in the library.');
  } else {
    for (var book in books) {
      book.display();
    }
  }
}

void addListBook() {
  if (books.isEmpty) {
    books.add(
      Book(idBook++, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Novel'),
    );
    books.add(
      Book(idBook++, 'Pride and Prejudice', 'Jane Austen', 1813, 'Novel'),
    );
    books.add(
      Book(
        idBook++,
        'A Brief History of Time',
        'Stephen Hawking',
        1988,
        'Science',
      ),
    );
    books.add(
      Book(
        idBook++,
        'The 7 Habits of Highly Effective People',
        'Stephen R. Covey',
        1989,
        "Self-help",
      ),
    );
    books.add(
      Book(idBook++, 'Atomic Habits', 'James Clear', 2018, 'Self-help'),
    );
  }
}

/// Adds a new book to the book list.
void addBooks() {
  try {
    stdout.write('Enter title for add new book: ');
    String? newTitle = stdin.readLineSync()!;

    stdout.write('Enter author for add new book: ');
    String? newAuthor = stdin.readLineSync()!;

    stdout.write('Enter year for add new book: ');
    int? newyear = int.parse(stdin.readLineSync()!);

    stdout.write('Enter genre for add new book: ');
    String? newGenre = stdin.readLineSync()!;

    Book newBook = Book(idBook, newTitle, newAuthor, newyear, newGenre);
    books.add(newBook);
    newBook.display();
    idBook++;
  } catch (e, s) {
    print('Error: $e , $s');
  }
}

// Edits an existing book based on its old title.
void editBook() {
  bool found = false;
  stdout.write('Enter ID for edit a book: ');
  int? editBook = int.parse(stdin.readLineSync()!);
  for (var book in books) {
    if (book.id == editBook) {
      found = true;
      stdout.write(''' Enter Number to edit:
      1- Title :
      2- Author:
      3- Year:
      4- Genre:
      5- Edit All:
       ''');

      int editNumber = int.parse(stdin.readLineSync()!);
      if (editNumber == 1) {
        stdout.write('Enter new title: ');
        book.title = stdin.readLineSync()!;
      } else if (editNumber == 2) {
        stdout.write('Enter new author: ');
        book.author = stdin.readLineSync();
      } else if (editNumber == 3) {
        stdout.write('Enter new year: ');
        book.year = int.parse(stdin.readLineSync()!);
      } else if (editNumber == 4) {
        stdout.write('Enter new genre: ');
        book.genre = stdin.readLineSync();
      } else if (editNumber == 5) {
        stdout.write('Enter new title: ');
        book.title = stdin.readLineSync();

        stdout.write('Enter new author: ');
        book.author = stdin.readLineSync();

        stdout.write('Enter new year: ');
        book.year = int.parse(stdin.readLineSync()!);

        stdout.write('Enter new genre: ');
        book.genre = stdin.readLineSync();
      } else {
        print('Invalid choice.');
      }
      book.display();
      break;
    }
  }
  if (!found) {
    print('Book not found');
  }
}

// Deletes a book from the list based on its title.
void deleteBook() {
  bool found = false;
  stdout.write('Enter ID book for delete: ');
  int deletBook = int.parse(stdin.readLineSync()!);
  for (var i = 0; i < books.length; i++) {
    if (deletBook == books[i].id) {
      books.removeAt(i);
      found = true;
      print('Book deleted successfully');
      break;
    }
  }
  if (!found) {
    print("No Book");
  }
}

// / Searches for a book by its title.
void searchBook() {
  bool found = false;
  stdout.write('search here: ');
  String? input = stdin.readLineSync();
  if (input == null || input.isEmpty) {
    print('no input.');
    return;
  }
  String searchWord = input.toLowerCase();
  for (var book in books) {
    if (book.title != null && book.title!.toLowerCase().contains(searchWord) ||
        book.author != null &&
            book.author!.toLowerCase().contains(searchWord) ||
        book.year.toString().contains(searchWord) ||
        book.id.toString().contains(searchWord) ||
        book.genre != null && book.genre!.toLowerCase().contains(searchWord)) {
      book.display();
      found = true;
    }
  }

  if (!found) {
    print('No book');
  }
}

// Sorts the book list alphabetically .
void sortBookTitle() {
  for (int i = 0; i < books.length; i++) {
    for (int j = i + 1; j < books.length; j++) {
      if (books[i].title!.compareTo(books[j].title!) > 0) {
        Book book2 = books[i];
        books[i] = books[j];
        books[j] = book2;
      }
    }
  }
}

void sortBookGenre() {
  for (int i = 0; i < books.length; i++) {
    for (int j = i + 1; j < books.length; j++) {
      if (books[i].genre!.compareTo(books[j].genre!) > 0) {
        Book book2 = books[i];
        books[i] = books[j];
        books[j] = book2;
      }
    }
  }
}

void sortBookYear() {
  for (int i = 0; i < books.length; i++) {
    for (int j = i + 1; j < books.length; j++) {
      if (books[i].year! > (books[j].year!)) {
        Book book2 = books[i];
        books[i] = books[j];
        books[j] = book2;
      }
    }
  }
}
