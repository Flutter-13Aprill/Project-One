import 'dart:io';

// A map to store books with their ID
Map<int, String> library = {};
int addId = 1;

class Book {
  String? title;
  String? author;
  int? year;
  String? categories;

  Book(this.title, this.author, this.year, this.categories);
  // A function to add new data in the library and csv file(database)
  void AddBook() {
    library[addId] =
        "Title: $title , Author: $author , Year: $year , categories: $categories .";
    File file = File('data.csv');
    file.writeAsStringSync(
      "\nTitle: $title , Author: $author , Year: $year , categories: $categories .",
      mode: FileMode.append,
    );
    // To remove empty data
    library.removeWhere((key, value) => value.trim().isEmpty);
  }
}

// A function to get data from csv file(database)
void data() {
  File file = File('data.csv');
  String contents = file.readAsStringSync();

  List<String> data = contents.split('\n');
  //Loop to add ID and data to library map
  for (var elm in data) {
    library[addId++] = elm;
  }
}

// Updates the CSV file(database) with the current library data
void updateFileData() {
  File file = File('data.csv');

  // To remove old data from the CSV file (database) and add the current library data
  file.writeAsStringSync("");

  for (var item in library.values) {
    file.writeAsStringSync("\n$item", mode: FileMode.append);

    // To remove empty data
    library.removeWhere((key, value) => value.trim().isEmpty);
  }
}

// function Takes two parameters: a method for adding/editing data, and the ID of the item to edit.

void addBook(String method, [int? id]) {
  print("-------------------------------");
  print("Enter the title of the book ");
  String title = stdin.readLineSync()!;

  print("-------------------------------");
  print("Enter the name of the author ?");
  String author = stdin.readLineSync()!;
  while (true) {
    print("-------------------------------");
    print("The year of publication ");

    // Error handling to check the user enters a number, not a string
    try {
      int? year = int.parse(stdin.readLineSync()!);

      if (year < 1400 || year >= 2026) {
        print("Invalid year");
        sleep(const Duration(seconds: 2));
      } else {
        print("-------------------------------");

        print("Enter categories : ");
        String? categories = stdin.readLineSync();

        // If method is new, create and add a new book
        if (method == "new") {
          Book book = Book(title, author, year, categories);
          book.AddBook();

          // If method is edit , update the existing book
        } else if (method == "edit") {
          library[id!] =
              "Title: $title , Author: $author , Year: $year , categories: $categories .";
          updateFileData();
        }

        print("Book added successfully");
        sleep(const Duration(seconds: 2));
        return;
      }
    } catch (e) {
      print("Invalid year");
      sleep(const Duration(seconds: 2));
    }
  }
}

// Displays all books  in the library
void displayBooks() {
  if (library.isEmpty) {
    print("There are no books in the library");
    sleep(const Duration(seconds: 2));
  } else {
    //Display each book in the library with its ID
    print("Book list : ");
    int i = 1;
    for (MapEntry book in library.entries) {
      print("id :$i , ${book.value}");
      i++;
    }

    // Wait for the user to return to the main menu
    while (true) {
      print("Enter 0 to return");
      String? choice = stdin.readLineSync();
      switch (choice) {
        case "0":
          return;

        default:
          print("Invalid number");
          sleep(const Duration(seconds: 1));
      }
    }
  }
}

// function to Searches for books by a searchWord
void searchBooks() {
  print("Search:");
  String searchWord = stdin.readLineSync()!.toLowerCase();
  bool found = false;

  // Loop to check if the keyword exists
  for (var item in library.entries) {
    String bookInfo = item.value.toLowerCase();
    if (bookInfo.contains(searchWord)) {
      print(item.value);
      found = true;
    }
  }
  if (found == false) {
    print("No results found");
  }

  // Wait for the user to return to the main menu
  while (true) {
    print("Enter 0 to return");
    String? choice = stdin.readLineSync();
    switch (choice) {
      case "0":
        return;

      default:
        print("Invalid number");
        sleep(const Duration(seconds: 1));
    }
  }
}

// function to update/edit a book's details by its ID
void editBook() {
  if (library.isEmpty) {
    print("There are no books in the library");
    sleep(const Duration(seconds: 2));
  }

  // Error handling to check the user enters a number, not a string
  try {
    print("Enter the ID of the book to edit:");
    int? id = int.parse(stdin.readLineSync()!);

    // Check if the ID exists in the library
    if (library.containsKey(id)) {
      addBook("edit", id);
    }
  } catch (e) {
    print("Invalid number");
    sleep(const Duration(seconds: 1));
  }
}

// Deletes a book from the library and updates the CSV file
void deleteBook() {
  if (library.isEmpty) {
    print("There are no books in the library");
    sleep(const Duration(seconds: 2));
  }
  print("Enter the ID of the book to delete:");
  try {
    int? id = int.parse(stdin.readLineSync()!);

    // Check if the ID exists in the library
    if (library.containsKey(id)) {
      library.remove(id);
      print("Deleted successfully");
      sleep(const Duration(seconds: 2));
    } else {
      print("ID not found");
      sleep(const Duration(seconds: 2));
    }
    updateFileData();
  } catch (e) {
    print("Please enter a number");
  }
}

void main() {
  // Load saved books from the CSV file
  data();

  //loop showing menu and handling user input
  while (true) {
    print("-------------------------------");

    print(" Choose a number : \n");
    print(" 1 : Displaying all books ");
    print(" 2 : Adding a new book ");
    print(" 3 : Editing a Book: ");
    print(" 4 : Searching for a Book");
    print(" 5 : Deleting a Book:");
    print(" 6 : exit ");
    print("-------------------------------");

    print("Select a number");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        displayBooks();
      case "2":
        addBook("new");
      case "3":
        editBook();
      case "4":
        searchBooks();
      case "5":
        deleteBook();
      case "6":
        exit(0);
    }
  }
}
