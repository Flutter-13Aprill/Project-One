import 'dart:io' as io;


// The list "books" will contain all the books (Objects created from "Book").
List<Book> books = [];

//This is the "Book" class which we will create books based on.
class Book {  
  String title;
  String author;
  int dateOfRelease;
  String genres;

  Book(this.title, this.author, this.dateOfRelease, this.genres);
  
}

void main () {
choices();

}

// This function is the home page of the program where the user can choose what to do in the program.
void choices () {
  print("Welcome to the library program");
  while (true) {
    print("\nwhat do you want to do: \nAdd a book: 1 \nDisplay available book: 2 \nEdit a book: 3 \nSearch for a book: 4  \nDelete a book: 5 \nExit the program: 6");
    String choice = io.stdin.readLineSync()!;
    switch (checkIntInput(choice)) {
      case 1 :
      createBook();
      break;

      case 2 :
      displayBooks();
      break;

      case 3 :
      editBook();
      break;

      case 4 :
      searchBook();
      break;

      case 5 :
      deleteBook();
      break;

      case 6 :
      exitProgram();
      break;

      default :
      print("Please enter a valid choice\n");
      break;
    } 
  }
}


// This function is for adding a book (object of "Book") to list "books".
void createBook () {
  print("\n Welcome to the add a book function");
  print("\n Please enter the title of the book you want to add");
  String newBookTitle = io.stdin.readLineSync()!;

  print("${"\n"} Please enter the author of $newBookTitle");
  String newBookAuthor = io.stdin.readLineSync()!;
 
  print("${"\n"} Please enter the date that $newBookTitle got released");
  String newBookDateOfRelease = io.stdin.readLineSync()!;

   print("${"\n"} Please enter the choose the genre for $newBookTitle ${"\n"}History: 1 ${"\n"}Novel: 2 ${"\n"}Science: 3 ${"\n"}Others: 4");
  String genre = io.stdin.readLineSync()!;

  Book book = Book(checkTitle(newBookTitle.toString()), checkAuthor(newBookAuthor.toString()), checkDate(newBookTitle.toString(), newBookDateOfRelease.toString()), genresCheck(checkIntInput(genre.toString())));
  books.add(book);
  print("${"\n"} the book titled: ${book.title} author: ${book.author} released in ${book.dateOfRelease} created successfully");
}


// This function display all the books (objects of "Book") that are saved on the list "books".
void displayBooks () {
  String displayChoice;
  bool displaySuccess = false;

  if (books.isEmpty) {
    print("Sorry the library is empty, Try to add a book to see it here \n");
    return;
  }

  while (!displaySuccess){
    print("Please choice type of display \nBy ID: 1 \nBy Title: 2 \nBy Release date: 3");
    displayChoice = io.stdin.readLineSync()!;

  switch(checkIntInput(displayChoice)) {
    case 1 :
    printBooks(books);
    displaySuccess = true;
    break;
  
    case 2 :
    sortByTitle(books);
    displaySuccess = true;
    break;

    case 3:
    sortByReleaseDate(books);
    displaySuccess = true;
    break;

    default:
    print("Sorry the choice entered is invalid, Please try again");
    break;

    }
  }
  
  return;
}


// This function edit an already existing book by identifing it's "ID".
void editBook() {
  bool editSucceed = false;
  print("\n Welcome to the editing function");
  
  // This statment is to check if the list "books" is empty.
  if(books.isEmpty){
      print("Sorry there isn't any book the library");
      return;
    }

  while(!editSucceed){
    
    print("\n Please enter the book id to edit the book");
    String bookIdString = io.stdin.readLineSync()!;
    int bookId = checkIntInput(bookIdString); 

    // Check if the number is larger than size of the (list length) and if the input is larger than 0. 
    if(bookId >= books.length || bookId < 0){
        print("sorry the id entered is wrong, Try again");
        continue;
        }

    while (!editSucceed) {
      print("What do you want to change: \n Title: 1 \n Author: 2 \n Release date: 3 \n genre: 4");
      String changeChoice = io.stdin.readLineSync()!;
      switch (checkIntInput(changeChoice)) {
        case 1:
          print("Enter the new title name:");
          String editedtitle = io.stdin.readLineSync()!;
          books[bookId].title = checkTitle(editedtitle);
          editSucceed = true;
          break;

          case 2:
          print("Enter the new author:");
          String editedAuthor = io.stdin.readLineSync()!;
          books[bookId].author = checkAuthor(editedAuthor);
          editSucceed = true;
          break;

          case 3:
          print("Enter the new release date:");
          String editedReleaseDate = io.stdin.readLineSync()!;
          books[bookId].dateOfRelease = checkDate(books[bookId].title, editedReleaseDate);
          editSucceed = true;
          break;

          case 4:
          print("Please enter the choose the new genre \n History: 1 \n Novel: 2 \n Science: 3 \n Others: 4");
          String genreChoice = io.stdin.readLineSync()!;
          books[bookId].genres = genresCheck(checkIntInput(genreChoice));
          editSucceed = true;
          break;

        default:
        print("Sorry the entered choice $changeChoice is wrong, Please try again");
      }
    }    
  }

  print("The change requested done successfully");
  return;
}


// This function search for an already existing book by identifing it's ID" then printing it's details.
void searchBook () {
  print("\n Welcome to the searching function");
  if(books.isEmpty){
    print("Sorry there isn't any book the library");
    return;
  }
  bool searchSucceed = false;
  String loopchoice;

  while (true) {
    print("Please enter the book Title or Author you are searching for");
    String searchString = io.stdin.readLineSync()!;
    // This set save the index of all the search result to prevent duplicate from the search in "Title" and "author"
    Set <int> resultSet = {};
    
    // This for loop will search the "title" and "author" of each element in the list "books" and add the result in the set result
    for (var element in books) {
      if(element.title.contains(searchString)){
        resultSet.add(element.title.indexOf(searchString));
        searchSucceed = true;
      }
      else if (element.author.contains(searchString)){
        resultSet.add(element.author.indexOf(searchString));
        searchSucceed = true;
      }
    }
 
    if(searchSucceed) {
      for(var element in resultSet) {
        print("The book you are searching for is${"\n"} ID: $element, Title: ${books[element].title}, Author: ${books[element].author}, Release date: ${books[element].dateOfRelease}");
      }
      return;
    }

    print("Sorry couldn't found a book with the details entered. \ntry again : 1 \nGet out: 2");
    loopchoice = io.stdin.readLineSync()!;
    if(checkIntInput(loopchoice) == 2) {
      return;
    }
  }
}


// This function search for an already existing book by identifing it's "ID" then remove it from the library.
void deleteBook () {
  print("\n Welcome to the deleting function");
  if(books.isEmpty){
    print("Sorry there isn't any book the library");
    return; 
  }
  int bookIndex;

  while(true){
    print("Please enter the ID of the book you want to delete");
    String bookIdString = io.stdin.readLineSync()!;
    bookIndex = checkIntInput(bookIdString);
    if(bookIndex >= books.length || bookIndex < 0){
        print("sorry the id entered is wrong, Try again");
        continue;
        }
    if(books.remove(books[bookIndex])){
      print("The Book deleted succefully");
      return;
    }
  }
}


// This function is to exit from the program.
void exitProgram() {
print("Thank you for using the library program, Goodbye");
io.exit(0);
}


// This function check validity of the "title".
String checkTitle (String bookTitle) {
  for (var element in books) {
  while(element.title == bookTitle) {
    print(element.title);
    print("${"\n"}the title $bookTitle already exist, Please Re-enter a new title");
    bookTitle = io.stdin.readLineSync()!;
  }
}
return bookTitle;
}

// This function is for the validation of the "author".
String checkAuthor (String bookAuthor) {
  for (var element in books) {
    while(element.author == bookAuthor) {
      print(element.author);
      print("the author $bookAuthor already exist, Please Re-enter a new author");
      bookAuthor = io.stdin.readLineSync()!;
    }
  }
  return bookAuthor;
}

// This function is for the validation of the "release date".
int checkDate (String bookTitle, String bookReleaseDate) {
  int releaseDate = checkIntInput(bookReleaseDate);
    while(releaseDate > 2025 || releaseDate < 0){
      print("the release date of $bookTitle is invalid, Please Re-enter it");
      releaseDate = checkIntInput(io.stdin.readLineSync()!);
    }
    return releaseDate;
}

// This function check if the genre choice is correct.
String genresCheck (int genre) {
  String bookGenre = ""; 
 while (true) {
  switch (genre) {

    case 1:
    bookGenre = "History";
      return bookGenre;

    case 2: 
      bookGenre = "Novel";
      return bookGenre;

    case 3:
      bookGenre = "Science";
      return bookGenre;

    case 4:
      bookGenre = "Others";
      return bookGenre;

    default:
    print("Sorry the entered choice is invalid, Please try again");
  }

}
  

}

// This function handle any invalid input (non numbered) and send the user back to the home menu if it catches it.
int checkIntInput (String isNumber) {
  late int value;
  while (true) {
    try {
     value = int.parse(isNumber);
  }
  catch (e){
    print("Sorry an invalid value has been entered will send you back to home menu");
    main();
  }
  break;
  }
  
  return value;
}



// This function go throgh all the items of the list provided and print it.
void printBooks (List listOfBooks) {
 for (var element in listOfBooks) {
  print("id :${books.indexOf(element)}, Title: ${element.title},  Author: ${element.author},  Date of release: ${element.dateOfRelease} ${"\n"}");
  } 
}

// This function sort the list provided by Title.
void sortByTitle (List listOfBooks) {
  List sortedByTitle = listOfBooks;
  sortedByTitle.sort((a,b) => a.title.compareTo(b.title));
  printBooks(sortedByTitle);
}

// This function sort the list provided by Author name.
void sortByReleaseDate (List listOfBooks) {
  List sortByReleaseDate = listOfBooks;
  sortByReleaseDate.sort((a,b) =>a.dateOfRelease.compareTo(b.dateOfRelease)); 
}

