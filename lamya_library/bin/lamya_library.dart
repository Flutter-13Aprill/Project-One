import 'package:lamya_library/book.dart' as book_library;
import 'package:lamya_library/manage_book.dart' as manage_books;
import 'dart:io' as io;

void main() {
  List<book_library.Book> books = [];
  bool isRunning = true; // For the condition

  // do while to repeat the menu until the user choose exit
  do {
    // the Library📚 meno
    print("\n📖 Welcome to Lamya Library 📖");
    print("1. Display all books 📚.");
    print("2. Add a new book ➕.");
    print("3. Edit an existing book 📝.");
    print("4. Search for a book 🔍.");
    print("5. Delete a book 🗑️.");
    print("6. Exit 🚪.");
    print("\nPlease choose one:");

    int? choice; // declear the choice

    // exceptions for the users who enter a string in int fild
    try {
      choice = int.parse(io.stdin.readLineSync()!);
    } catch (e) {
      print("⚠️ Invalid input. Try again.");
      continue;
    }

    // Create an objec
    var manager = manage_books.ManageBooks(0, '', '', 0, '');

    // Switch for the choices
    switch (choice) {
      case 1:
        print("\n📚 Displaying all books...");
        manager.displayBooks(books);
        break;
      case 2:
        print("\n➕ Adding a new book...");
        manager.addBook(books);
        break;
      case 3:
        print("\n📝 Edit an existing book...");
        manager.editBook(books);
        break;
      case 4:
        print("\n🔎 Searching for a book...");
        manager.searchForBook(books);
        break;
      case 5:
        print("\n🗑️ Deleting a book...");
        manager.deleteBook(books);
        break;
      case 6:
        print("\n👋 Goodbye!");
        isRunning = false;
        break;
      default:
        print("\n❗ Invalid choice. Please try again.");
        break;
    }
  } while (isRunning);
}
