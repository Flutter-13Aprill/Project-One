import 'package:lamya_library/book.dart' as book_library;
import 'dart:io' as io;
import 'dart:math' as math;

//searches by book ID
book_library.Book? foundBook;
mixin FindId {
  findId(List<book_library.Book> books) {
    foundBook = null;
    print("Pleas enter the book ID :");
    int? inputId;
    try {
      inputId = int.parse(io.stdin.readLineSync()!);
    } catch (e) {
      print("⚠️ Invalid input.");
      return;
    }
    // Try to find the book
    for (book_library.Book book in books) {
      if (book.bookId == inputId) {
        foundBook = book;
        print("✅ Book found: $inputId.");
        print(foundBook);
        return;
      }
    }
    print("❌ No book found with ID $inputId.");
  }
}

//manage all book operations
class ManageBooks extends book_library.Book with FindId {
  ManageBooks(
    super.bookId,
    super.title,
    super.author,
    super.year,
    super.categories,
  );

  //Display books
  displayBooks(List<book_library.Book> books) {
    if (books.isEmpty) {
      print("\n📭 No books in the library.");
      return;
    }
    print("\nList of the books 📚:"); // caption
    //sort by year
    books.sort((a, b) => a.year.compareTo(b.year));
    for (book_library.Book book in books) {
      print(book); // display the book info
      print("--------------------------\n");
    }
  }

  //Gets user input and adds new Book to the list
  addBook(List<book_library.Book> books) {
    try {
      math.Random random = math.Random();
      int newId = random.nextInt(100) + 1;
      // Ensure unique ID
      while (books.any((book) => book.bookId == newId)) {
        newId++;
      }
      print("Pleas enter the book title 📖 :");
      title = io.stdin.readLineSync()!;
      //Handl empty inputs.
      if (title.isEmpty) {
        print("⚠️ Title cannot be empty.");
        return;
      }
      //Checks for duplicate titles.
      for (book_library.Book book in books) {
        if (book.title.toLowerCase() == title.toLowerCase()) {
          print("⚠️ This book has already been added.");
          return;
        }
      }
      print("Pleas enter the book Author ✍️ :");
      author = io.stdin.readLineSync()!;
      //Handl empty inputs.
      if (author.isEmpty) {
        print("⚠️ Title cannot be empty.");
        return;
      }
      print("Pleas enter the book Published year 🗓️ :");
      String? stYear = io.stdin.readLineSync()!;
      //Handl empty inputs.
      if (stYear.isEmpty) {
        print("⚠️ Title cannot be empty.");
        return;
      }
      int year = int.parse(stYear);
      //Check the validation of the year
      if (year < 1000 || year > DateTime.now().year) {
        print("⚠️ Invalid year.");
        return;
      }

      print("Pleas enter the categories of the book 📚 (optional):");
      categories = io.stdin.readLineSync()!;

      book_library.Book newBook = book_library.Book(
        newId,
        title,
        author,
        year,
        categories,
      );
      books.add(newBook);
      print("✅ Book added successfully! with ID: $newId \n");
    } catch (e) {
      print("⚠️ Invalid input.");
      return;
    }
  }

  // Uses findId to get the book then allows updating fields
  editBook(List<book_library.Book> books) {
    findId(books);
    if (foundBook == null) {
      return;
    } else {
      // Ask the user for new data
      print("Enter new title (leave empty to keep current):");
      String? newTitle = io.stdin.readLineSync();
      if (newTitle != null && newTitle.isNotEmpty) {
        foundBook?.title = newTitle;
      }

      print("Enter new author (leave empty to keep current):");
      String? newAuthor = io.stdin.readLineSync();
      if (newAuthor != null && newAuthor.isNotEmpty) {
        foundBook?.author = newAuthor;
      }

      print("Enter new year (leave empty to keep current):");
      String? newYear = io.stdin.readLineSync();
      if (newYear != null && newYear.isNotEmpty) {
        int updatedYear = int.parse(newYear);
        foundBook?.year = updatedYear;
      }

      print("Enter new category (leave empty to keep current):");
      String? newCategory = io.stdin.readLineSync();
      if (newCategory != null && newCategory.isNotEmpty) {
        foundBook?.categories = newCategory;
      }

      print("✅ Book updated: \n$foundBook");
    }
  }

  // Finds books by title or author keyword
  searchForBook(List<book_library.Book> books) {
    print("Please enter what you're searching for:");
    String keywords = io.stdin.readLineSync()!;
    bool found = false;
    //Check the matching string
    for (book_library.Book book in books) {
      if (book.title.toLowerCase().contains(keywords) ||
          book.author.toLowerCase().contains(keywords)) {
        print(book);
        found = true;
      }
    }

    if (!found) {
      print("❌ No book found matching '$keywords'.");
    }
  }

  // Finds book by ID and removes it from the list
  deleteBook(List<book_library.Book> books) {
    findId(books);
    if (foundBook == null) {
      return;
    } else {
      books.remove(foundBook);
      print("✅ Book with ID ${foundBook!.bookId} has been deleted 🗑️.");
    }
  }
}
