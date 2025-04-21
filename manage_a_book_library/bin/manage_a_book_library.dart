import 'dart:io';

void main() {
  List<Map<String, dynamic>> books = [];

  while (true) {
    print('\nLibrary Menu:');
    print('1. Add Book');
    print('2. Search Book');
    print('3. Edit Book');
    print('4. Delete Book');
    print('5. Show All Books');
    print('0. Exit');
    stdout.write('Enter your choice: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addBook(books);
        break;
      case '2':
        searchBook(books);
        break;
      case '3':
        editBook(books);
        break;
      case '4':
        deleteBook(books);
        break;
      case '5':
        showBooks(books);
        break;
      case '0':
        print('Exiting program...');
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void addBook(List<Map<String, dynamic>> books) {
  stdout.write('Enter title: ');
  String? title = stdin.readLineSync();

  stdout.write('Enter author: ');
  String? author = stdin.readLineSync();

  stdout.write('Enter ISBN: ');
  int isbn = int.parse(stdin.readLineSync()!);

  books.add({
    'title': title,
    'author': author,
    'isbn': isbn,
  });

  print('Book added successfully.');
}

void searchBook(List<Map<String, dynamic>> books) {
  stdout.write('Enter keyword to search (title or author): ');
  String keyword = stdin.readLineSync()!.toLowerCase();

  var results = books.where((book) =>
      book['title'].toLowerCase().contains(keyword) ||
      book['author'].toLowerCase().contains(keyword)).toList();

  if (results.isEmpty) {
    print('No books found.');
  } else {
    print('\nSearch Results:');
    for (var book in results) {
      print('- ${book['title']} by ${book['author']} (ISBN: ${book['isbn']})');
    }
  }
}

void editBook(List<Map<String, dynamic>> books) {
  stdout.write('Enter title of the book to edit: ');
  String title = stdin.readLineSync()!;

  for (var book in books) {
    if (book['title'].toLowerCase() == title.toLowerCase()) {
      stdout.write('New author: ');
      book['author'] = stdin.readLineSync();

      stdout.write('New ISBN: ');
      book['isbn'] = int.parse(stdin.readLineSync()!);

      print('Book updated successfully.');
      return;
    }
  }

  print('Book not found.');
}

void deleteBook(List<Map<String, dynamic>> books) {
  stdout.write('Enter title of the book to delete: ');
  String title = stdin.readLineSync()!;

  int before = books.length;
  books.removeWhere((book) => book['title'].toLowerCase() == title.toLowerCase());

  if (books.length < before) {
    print('Book deleted.');
  } else {
    print('Book not found.');
  }
}

void showBooks(List<Map<String, dynamic>> books) {
  if (books.isEmpty) {
    print('No books in the library.');
    return;
  }

  print('\nLibrary Collection:');
  for (var book in books) {
    print('- ${book['title']} by ${book['author']} (ISBN: ${book['isbn']})');
  }
}

