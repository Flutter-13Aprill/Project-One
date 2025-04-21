import 'dart:io' as io;
List<Book> bookLibrary = [];
void main(){


  bool startProgram = true; // all program will be inside while loop, and when user choos (0) startProgram will be false and stop program

  while(startProgram){
// ===================================== option menue section =====================================
    print("hello to my library, whad do you want?");
    print("1 - show availble books");
    print("2 - add new book to library");
    print("3 - edit the details of an existing book");
    print("4 - search for a book");
    print("5 - delete book from library");
    print("0 - exit from system"); // add from me "so user now can out from system when he want"
// ===================================== end option menue =====================================

// ================================= input validation section =================================
    int choise = -1; // initial value to insure will enter validation while loop and cant uot untill user enter valid number
    //inside while loop Input validation with try-catch as you  ask in "Skills and Knowledge Required:"
    while(choise < 0 || choise > 5){ 
      print("please choose serve of list");
      try{
        String? input = io.stdin.readLineSync();
        if(input == null || input.trim().isEmpty){ // here will check if input empty or no, not important any thing else
          throw FormatException(); // if empty will go to catch 
        }
        choise = int.parse(input);
        if(choise < 0 || choise > 5){ // if not empty or null, will check if it in range 0-5, if yes will skip if statement
          print("============== please number shuold be beyween 0-5 ===================="); // if no will print this and go to cach
        }
      }
      catch(e){
        print("============== invalid input - please enter number between 0-5 ================");
        choise = -1; //this to isure you cant out untill enter valid value
      }
    }
// ================================= end validation section =================================

// =================================== swtich case section ==================================
    switch(choise){
      case 1: // thise numbers from user 0-3, every numbber match case in switch
        showBook(bookLibrary);
        break;
      case 2:
        addBook(bookLibrary);
        break;
      case 3:
        editBook(bookLibrary);
        break;
      case 4:
        searchBooks(bookLibrary);
        break;
      case 5:
        deleteBook(bookLibrary);
        break;
      case 0:
        print("+++ see you later +++");
        startProgram = false; // if user want to out, startProgram variable will be false (this is the condiion in while loop)
        break;
    }
// =================================== end swtich  section ===================================
  } // close while loop
} // close main 

// ===========================================================================================
// ==================================== functions section ====================================
// ===========================================================================================

// ================================== showing book function ==================================
void showBook(List<Book> library){
  if (library.isEmpty){ // to check if list empty or no
    print("______ no book yet ______"); // if empty will print this and skip other
  }
  else {
    print(" these book is found:");
    for (int i = 0; i < library.length; i++){ // if not empty will print all books in list using for loop
      print("${i + 1} - ${library[i]} ");
    }
  }
}
// ================================== end showing function ===================================

// ====================================== add function =======================================
void addBook(List<Book> library) {
  print("title:");
  String? title = io.stdin.readLineSync(); // to let user enter title 
  if(title == null || title.trim().isEmpty){ //// this if statement to insure there is a name, if no as defoult will be "unknown"
    title = "unknown";
  }
  print("author name:");
  String? author = io.stdin.readLineSync(); // to lrt user enter author
  if(author == null || author.trim().isEmpty){ // exactly like title above
    author = "unknown";
  }
  
  int year = -1; // as initial value to enter hwile loop
  while(year <= 1){
    print("publication year:");
    try{
      String? input = io.stdin.readLineSync();
      if(input == null || input .trim().isEmpty){ // chick if input empty
        throw FormatException();
      }
      year = int.parse(input); // will arrive here only if input not empty or null
      if (year <= 0){ // if number positiv will skip this
        print("======================== enter positeve number ========================");
      }
    }
    catch(e){
      print("======================= try again ======================");
      year = -1; // user cant out till enter valid number
    } 
  }

  Book newBook = Book(title, author, year);
  library.add(newBook); // add new book to bookLibrary
  print("------- add done --------");
}
// ====================================== add function =======================================

// ================================== edit details function ==================================
void editBook(List<Book> library) {
  if (library.isEmpty) {
    print("_____ no books to edit. ______");  // check if there is any book
    return;
  }

  print("📚 books:");
  for (int i = 0; i < library.length; i++) { // show book list
    print("▶ ${i + 1} - ${library[i]}");
  }

  int index = -1; // validate number input
  while (index < 0 || index >= library.length) {
    print("Enter the number of the book you want to edit (1-${library.length}):");
    try {
      String? input = io.stdin.readLineSync();
      if (input == null || input.trim().isEmpty) {
        throw FormatException();
      }
      index = int.parse(input) - 1;
      if (index < 0 || index >= library.length) {
        print("=========================== Invalid number. Try again. ===========================");
      }
    } catch (e) {
      print("========================= Invalid input ============================");
      index = -1; // if error will back
    }
  }

  Book book = library[index]; 

  print("no change? leave it empty");

  print("title:");
  String? newTitle = io.stdin.readLineSync();
  if (newTitle != null && newTitle.trim().isNotEmpty) {
    book.title = newTitle.trim(); // if not empty will change 
  }

  print("author:");
  String? newAuthor = io.stdin.readLineSync();
  if (newAuthor != null && newAuthor.trim().isNotEmpty) {
    book.author = newAuthor.trim(); // if not empty will change 
  }

  print("year:");
  String? newYearInput = io.stdin.readLineSync();
  if (newYearInput != null && newYearInput.trim().isNotEmpty) {
    try {
      int newYear = int.parse(newYearInput.trim());
      if (newYear > 0) {
        book.year = newYear;
      } else {
        print("must be positive number");
      }
    } catch (e) {
      print("Invalid year input. Keeping the old year."); // if rmpty or invalid will skpi
    }
  }

  print("--------------------------- edit done --------------------------");
}
// ================================== end edit function ==================================

// ================================== search book function ===============================
void searchBooks(List<Book> library) {
  if (library.isEmpty) {
    print("========================= No books to search ========================");
    return;
  }

  print("Enter a keyword to search by title or author:");
  String? keyWord = io.stdin.readLineSync();

  if (keyWord == null || keyWord.trim().isEmpty) {
    print("========================= Search keyword cannot be empty. =========================");
    return;
  }

  String searchTerm = keyWord.trim().toLowerCase();
  List<Book> results = library.where((book) =>
    book.title.toLowerCase().contains(searchTerm) ||
    book.author.toLowerCase().contains(searchTerm) // key word that you enter will check by (where), if contain will apper, if not will print no with this woord
  ).toList();

  if (results.isEmpty) {
    print("================= No books found matching '$searchTerm'. ====================");
  } else {
    print("=========================== Found ${results.length} book(s): ========================");
    for (var book in results) {
      print("- $book"); // print book with this key word
    }
  }
}
// ================================== rdn search function ==================================

// ================================== remove book function ==================================
// ============================================
void deleteBook(List<Book> library) {          
  if (library.isEmpty) {                         
    print(" ________ no book to remove _______"); 
    return;                                        
  }                                                 
                                  // check if there is any book in library, and print all books                 
  print("📚 List of books:");                     
  for (int i = 0; i < library.length; i++) {       
    print("${i + 1}. ${library[i]}");            
  }                                             
// =============================================
  int index = -1; // validation number input
  while (index < 0 || index >= library.length) {
    print("Enter the number of the book you want to delete (1-${library.length}):");
    try {
      String? input = io.stdin.readLineSync();
      if (input == null || input.trim().isEmpty) {
        throw FormatException();
      }
      index = int.parse(input) - 1;
      if (index < 0 || index >= library.length) {
        print("============ Invalid number. Try again. =============");
      }
    } catch (e) {
      print("========== Invalid input ===========}");
      index = -1;
    }
  }

  // Confirm before deleting
  print("Are you sure you want to delete this book?");
  print("▶ ${library[index]}"); // insuring tha you want to delet it
  print("Type Y to confirm or any other key to cancel:");
  String? confirm = io.stdin.readLineSync(); 

  if (confirm != null && confirm.toUpperCase() == 'Y') {
    library.removeAt(index);
    print("---------- delet done ----------");
  } else {
    print("--------- cancel delet ---------"); // if dont typ "Y" deleted will cancel
  }
}


// ================================== end remove function ===================================

class Book { // this Book class, has 3 object, title, author, year
  String title;
  String author;
  int year;
  Book(this.title, this.author, this.year);

  @override
  String toString() {
    return 'Title: $title, Author: $author, Year: $year';
  }
}

