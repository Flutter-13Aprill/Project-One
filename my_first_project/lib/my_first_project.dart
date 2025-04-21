import 'dart:io';
import 'dart:math';

class Books {
  final int? _id;
  String? _bookTitle;
  String? _bookAuthor;
  int? _publiactionYear;
  String? _category;

  Books(
    this._id,
    this._bookTitle,
    this._bookAuthor,
    this._publiactionYear,
    this._category,
  );

  int get bookId {
    return _id!;
  }

  set bookTitle(String? bookTitle) {
    _bookTitle = bookTitle;
  }

  set bookAuthor(String? bookAuthor) {
    _bookAuthor = bookAuthor;
  }

  set publiactionYear(int? publiactionYear) {
    _publiactionYear = publiactionYear;
  }

  set bookCategory(String? bookCategory) {
    _category = bookCategory;
  }

  String get bookTitle {
    return _bookTitle!;
  }

  String get bookAuthor {
    return _bookAuthor!;
  }

  int get publiactionYear {
    return _publiactionYear!;
  }

  String get bookCategory {
    return _category!;
  }
}

List<Books> objects = [];
Set<int> ids = {};
// Function to add a new book, and check if the book already exists
void addBook() {
  int id = uniqueId();
  bool duplicated = false;
  print("What is the title of the book?");
  String bookTitle = stdin.readLineSync()!;

  print("Who is the author of the book?");
  String authorName = stdin.readLineSync()!;

  print("What year was the book published?");
  int publicationYear = int.parse(stdin.readLineSync()!);

  print(
    "Book categories: \n1- History \n2- Science \n3- Novel \n4- Crime \n5- Religious",
  );
  print("\nWhat category does the book belong to?");
  int? categoryOption;
  try {
    categoryOption = int.parse(stdin.readLineSync()!);
  } catch (e, s) {
    print("Error, please enter a valid number.");
    print("$s");
  }
  String categoryName;
  switch (categoryOption) {
    case 1:
      categoryName = "History";
    case 2:
      categoryName = "Science";
    case 3:
      categoryName = "Novel";
    case 4:
      categoryName = "Crime";
    case 5:
      categoryName = "Religious";
    default:
      categoryName = "Not Specified";
  }

  for (int i = 0; i < objects.length; i++) {
    if (objects[i].bookTitle.contains(bookTitle) &&
        objects[i].bookAuthor.contains(authorName)) {
      duplicated = true;
    }
  }
  if (duplicated) {
    print("Sorry, book already exist");
  } else {
    Books book = Books(
      id,
      bookTitle,
      authorName,
      publicationYear,
      categoryName,
    );
    objects.add(book);
    print("The book was added successfully ✅");
  }
}

// Function to display all books in the library
void displayBooks() {
  if (objects.isEmpty) {
    print("Sorry, the library is empty");
  } else {
    print("Sort by:\n1- Book Title \n2- Publication Year");
    int? sortOption;
    try {
      sortOption = int.parse(stdin.readLineSync()!);
    } catch (e, s) {
      print("Error, please enter a valid number.");
      print("$s");
    }
    if (sortOption == 1) {
      objects.sort((a, b) {
        return a.bookTitle.toLowerCase().compareTo(b.bookTitle);
      });
    } else if (sortOption == 2) {
      objects.sort((a, b) {
        return a.publiactionYear.compareTo(b.publiactionYear);
      });
    } else {
      print("please enter a valid number.");
    }
    for (int i = 0; i < objects.length; i++) {
      print(
        "Book ID: ${objects[i].bookId}, Book title: ${objects[i].bookTitle}, Book Author: ${objects[i].bookAuthor}, Publication Year: ${objects[i].publiactionYear},  Book Cayegory: ${objects[i].bookCategory} ",
      );
    }
  }
}

// Function to search for a book by book title
void searchByBookTitle() {
  print("Please enter book title you want");
  String title = stdin.readLineSync()!;
  int i, count = 0;
  for (i = 0; i < objects.length; i++) {
    if (objects[i].bookTitle.toLowerCase().startsWith(title.toLowerCase())) {
      print(
        "Book ID: ${objects[i].bookId}, Book title: ${objects[i].bookTitle}, Book Author: ${objects[i].bookAuthor}, Publication Year: ${objects[i].publiactionYear},  Book Cayegory: ${objects[i].bookCategory} ",
      );
      count++;
    }
  }
  if (count == 0) {
    print("Sorry, not found");
  }
}

// Function to search for a book by book author
void searchByBookAuthor() {
  print("Please enter book author you want");
  String author = stdin.readLineSync()!;
  int i, count = 0;
  for (i = 0; i < objects.length; i++) {
    if (objects[i].bookAuthor.toLowerCase().startsWith(author.toLowerCase())) {
      print(
        "Book ID: ${objects[i].bookId}, Book title: ${objects[i].bookTitle}, Book Author: ${objects[i].bookAuthor}, Publication Year: ${objects[i].publiactionYear},  Book Cayegory: ${objects[i].bookCategory} ",
      );
      count++;
    }
  }

  if (count == 0) {
    print("Sorry, not found");
  }
}

// Function to search for a book by book category
void searchByBookCategory() {
  int i, count = 0;

  print(
    "Book categories: \n1- History \n2- Science \n3- Novel \n4- Crime \n5- Religious",
  );
  print("\nChoose a book category");
  int categoryOption = int.parse(stdin.readLineSync()!);

  String categoryName;
  switch (categoryOption) {
    case 1:
      categoryName = "History";
    case 2:
      categoryName = "Science";
    case 3:
      categoryName = "Novel";
    case 4:
      categoryName = "Crime";
    case 5:
      categoryName = "Religious";
    default:
      categoryName = "Not Specified";
  }

  for (i = 0; i < objects.length; i++) {
    if (objects[i].bookCategory.toLowerCase().contains(
      categoryName.toLowerCase(),
    )) {
      print(
        "Book ID: ${objects[i].bookId}, Book title: ${objects[i].bookTitle}, Book Author: ${objects[i].bookAuthor}, Publication Year: ${objects[i].publiactionYear},  Book Cayegory: ${objects[i].bookCategory} ",
      );
      count++;
    }
  }

  if (count == 0) {
    print("Sorry, not found");
  }
}

// Function to edit details of an existing book
void editBookInfo(int? id) {
  int i;
  print(
    "what do you want to edit\n1- book title\n2- book author\n3- publication year\n4- book category",
  );
  int? editOption;
  try {
    editOption = int.parse(stdin.readLineSync()!);
  } catch (e, s) {
    print("Error, please enter a valid number.");
    print("$s");
  }
  for (i = 0; i < objects.length; i++) {
    if (objects[i].bookId == id) {
      print(
        "Book ID: ${objects[i].bookId}, Book title: ${objects[i].bookTitle}, Book Author: ${objects[i].bookAuthor}, Publication Year: ${objects[i].publiactionYear},  Book Cayegory: ${objects[i].bookCategory} ",
      );
      switch (editOption) {
        case 1:
          print("What is the new title of the book?");
          String bookTitle = stdin.readLineSync()!;
          objects[i].bookTitle = bookTitle;
        case 2:
          print("Who is the new author of the book?");
          String authorName = stdin.readLineSync()!;
          objects[i].bookAuthor = authorName;

        case 3:
          print("What year was the book published?");
          int publicationYear = int.parse(stdin.readLineSync()!);

          objects[i].publiactionYear = publicationYear;
        case 4:
          print(
            "Book categories: \n1- History \n2- Science \n3- Novel \n4- Crime \n5- Religious\n",
          );
          print("\nChoose a book category");
          int? categoryOption;
          try {
            categoryOption = int.parse(stdin.readLineSync()!);
          } catch (e, s) {
            print("Error, please enter a valid number.");
            print("$s");
          }
          String categoryName;
          switch (categoryOption) {
            case 1:
              categoryName = "History";
            case 2:
              categoryName = "Science";
            case 3:
              categoryName = "Novel";
            case 4:
              categoryName = "Crime";
            case 5:
              categoryName = "Religious";
            default:
              categoryName = "Not Specified";
          }
          objects[i].bookCategory = categoryName;
      }
      break;
    }
  }
  if (i == objects.length) {
    print("Sorry, not found");
  }
}

// Function to delete a book from the library
void removeBook(int? id) {
  int i, count = 0;
  for (i = 0; i < objects.length; i++) {
    if (objects[i].bookId == id) {
      objects.removeAt(i);
      print("The book was removed successfully ✅");
      count++;
      break;
    }
  }
  if (count == 0) {
    print("Sorry, not found");
  }
}

// Function to generate a new unique id
int uniqueId() {
  int id;
  do {
    id = Random().nextInt(100);
  } while (ids.contains(id));
  ids.add(id);
  return id;
}
