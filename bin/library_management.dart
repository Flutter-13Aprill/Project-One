import 'dart:convert';
import 'dart:io';
import 'book.dart';


// Creating Directory & json file to store books
Directory localStorageDirectory = Directory('./local_storage');
bool isLocalStorageDirExist = localStorageDirectory.existsSync();
File booksJsonFile = File('./local_storage/books_file.json');
bool isBooksJsonFileExist = booksJsonFile.existsSync();


void main(){

  bool isProgramActive = true;
  stdout.write('\n-----------------------------------------\n');
  stdout.write('Welcome to the Library Management CLI Program\n');

  // List of books
  List<Book> books = [];  

  // Check if the file exist in local storage
  // - If it exists read the data from json file
  // - If not, create the dir and file
  if(isLocalStorageDirExist && isBooksJsonFileExist){      

    String booksAsJsonString = booksJsonFile.readAsStringSync();

    // If the json string not empty convert it to Json objects
    if(booksAsJsonString != ''){
      
      List<dynamic> booksData = jsonDecode(booksAsJsonString);
      
      for(final bookAsJson in booksData){
        Book book = Book.fromJson(bookAsJson);
        books.add(book);
      }
    }

  }else{
    localStorageDirectory.createSync();
    booksJsonFile.createSync();
  }

  do{

    try{

      // Asking the user which action to perform
      stdout.write('''\nWhat would you like to do? 
1 - List books
2 - Search for a book
3 - Add a book
4 - Edit an existing book
5 - Delete a book
6 - Exit the program
Enter a number to choose an action: ''');
      String? userSelectionAction = stdin.readLineSync();

      if(userSelectionAction == '1'){

        listBooks(books: books);

      }else if (userSelectionAction == '2'){

        searchForBook(books: books);

      }else if(userSelectionAction == '3'){

        books = addNewBook(books: books);

      }else if(userSelectionAction == '4'){

        books = editBook(books: books);

      }else if(userSelectionAction == '5'){
        
        books = deleteBook(books: books);

      }else if(userSelectionAction == '6'){
        

        isProgramActive = false;

      }else if(RegExp(r'^[A-Z]+[a-z]+|[a-z]+[A-Z]+|[a-z]+|[A-Z]+$').hasMatch(userSelectionAction ?? '')){

        String correctWord = userSelectionAction!.length > 1 ? 'sentence' : 'letter';
        throw Exception('You have entered a $correctWord\nMake sure to enter a corresponding number to perform an action\n');
        
      }else{

        throw Exception('You have entered a wrong number or special letter\nMake sure to enter a corresponding number to perform an action\n');

      }

    }catch(error){

      print('\n----------------------------------------------------------------');
      print('\nError\n$error');
      print('----------------------------------------------------------------');

    }

  }while(isProgramActive);

  print('\n----------------------     See you next time     ----------------------');
  print('\n----------------------       Made with Love      ----------------------');
  print('\n----------------------       GitHub: @2Mhd6      ----------------------\n');

}


void listBooks({required List<Book> books}){

  if(books.isEmpty){

    print('\n--------------Listing Books--------------\n');
    print('Your shelf is currently empty.');
    print('\n-----------------------------------------\n');

  }else{
    
    print('\n-------------Listing Books------------\n');

    // Sorting books based on alphabetical order
    books.sort((b1,b2){
      
      if(b1.getTitle == null || b2.getTitle == null){
        return 0; 
      }

      // I forced to unwrap because in pervious line I checked if any of the values are null, return 0.
      return b1.getTitle!.compareTo(b2.getTitle!);
    });

    for(final book in books){
      displayBook(book: book);
    }

    print('\n--------------------------------------');
  }
}

void searchForBook({required List<Book> books}){

  if(books.isEmpty){

    print('\n--------------Searching for Books----------------\n');
    print('Your shelf is currently empty.');
    print('\n-------------------------------------------------\n');

    return;
  }

  stdout.write('Which book are you looking for (Title/Author/Genre name): ');
  String? dataAboutBook = stdin.readLineSync();

  // Checking if the user didn't enter anything
  if(dataAboutBook == null || dataAboutBook.trim().isEmpty){

    print('\n--------------Searching for Books--------------\n');
    print('You haven\'t entered any book details.');
    print('Please enter a valid book name or information.');
    print('\n-----------------------------------------------\n');

    return;
  }

  List<Book> searchedBook = books.where((book){
    if(book.getTitle!.toLowerCase().contains(dataAboutBook.toLowerCase()) || book.getAuthor!.toLowerCase().contains(dataAboutBook.toLowerCase()) || book.getGenre!.toLowerCase().contains(dataAboutBook.toLowerCase())){
      return true;
    }
    return false;
  }).toList();
  
  if(searchedBook.isEmpty){
    print('\n--------------Searching for Books------------------\n');
    print('No book with this information is found on your shelf.');
    print('\n---------------------------------------------------\n');
    return;
  }


  print('\n--------------Searching for Books--------------\n');

  for(var book in searchedBook){
    displayBook(book: book);
  }

  print('\n-----------------------------------------------');
  

}


List<Book> addNewBook({required List<Book> books}){

  print('\n--------------Adding a New Book--------------\n');

  
  stdout.write('Enter the title of the book: ');
  String? title = stdin.readLineSync();
  
  List<Book> areThereDuplicatedBooks = books.where((book) => book.getTitle?.toLowerCase() == title?.toLowerCase()).toList();

  if(areThereDuplicatedBooks.isNotEmpty){
    print('"$title" is already on your shelf.');
    print('\n---------------------------------------------');
    return books;
  }

  stdout.write('Enter the author\'s name: ');
  String? author = stdin.readLineSync();

  stdout.write('Enter the genre name: ');
  String? genre = stdin.readLineSync();

  stdout.write('Enter the publication year: ');
  int? publicationYear = int.tryParse(stdin.readLineSync() ?? '');
  
  final newBook = Book(title: title, author: author, genre:genre, publicationYear: publicationYear);

  books.add(newBook);
  print('$title has been added to your shelf.');
  print('\n---------------------------------------------\n');

  // Saving changes into book_file.json
  String booksAsJsonString = jsonEncode(books.map((book) => book.toJson()).toList());
  booksJsonFile.writeAsStringSync(booksAsJsonString);

  return books;
}

List<Book> editBook({required List<Book> books}){
  
  print('\n--------------Editing a Book--------------\n');

  if(books.isEmpty){
    print('Your shelf is currently empty.');
    print('\n------------------------------------------\n');
    return books;
  }

  // Asking for the name of the book that will be modified
  stdout.write('Enter name of the book you want to edit: ');
  String? nameOfBook = stdin.readLineSync();

  // Trying to check if the book exist in the list
  final Book book = books.firstWhere((book) => book.getTitle == nameOfBook, orElse:() => Book(title: null, author: null, genre: null, publicationYear: null));

  
  if(books.contains(book)){
    
    // Getting the index of existing book
    int index = books.indexOf(book);

    stdout.write('Enter a new title for ${book.getTitle}: ');
    String? newTitle = stdin.readLineSync();

    stdout.write('Enter a new author name for ${book.getTitle}: ');
    String? newAuthorName = stdin.readLineSync();

    stdout.write('Enter a new genre name for ${book.getTitle}: ');
    String? newGenreName = stdin.readLineSync();

    stdout.write('Enter a new publication year for ${book.getTitle}: ');
    int? newPublicationYear = int.tryParse(stdin.readLineSync() ?? '');

    final editedBook  = Book(title: newTitle, author: newAuthorName, genre: newGenreName, publicationYear: newPublicationYear);
    
    books[index] = editedBook;
    
    print('Changes to "${book.getTitle}" have been saved.');
    print('\n------------------------------------------\n');


  }else{

    print('\n-------------------Editing a Book---------------------\n');
    print('No book with this information is found on your shelf.');
    print('\n------------------------------------------------------\n');

    return books;
  }
  
  // Saving changes into book_file.json
  String booksAsJsonString = jsonEncode(books.map((book) => book.toJson()).toList());
  booksJsonFile.writeAsStringSync(booksAsJsonString);
  return books;
}

List<Book> deleteBook({required List<Book> books}){

  print('\n-------------------Deleting a Book-----------------\n');

  if(books.isEmpty){
    print('Your shelf is currently empty.');
    print('\n---------------------------------------------------\n');
    return [];
  }

  stdout.write('Enter the name of the book you want to delete: ');
  String? title = stdin.readLineSync();
  
  
  // Check if the book exists in the list, if not, return a book with null values,
  // which will result in an index of -1.
  final Book deletedBook = books.firstWhere((book) => book.getTitle! == title, orElse:() => Book(title: null, author: null, genre: null, publicationYear: null));
  final index = books.indexOf(deletedBook);


  if(index == -1){

    print('No book with this information is found on your shelf.');
    print('\n---------------------------------------------------\n');

    return books;
  }

  books.removeAt(index);
  print('\nThe book "${deletedBook.getTitle}" has been successfully deleted');
  print('\n---------------------------------------------------\n');

  // Saving changes into book_file.json
  String booksAsJsonString = jsonEncode(books.map((book) => book.toJson()).toList());
  booksJsonFile.writeAsStringSync(booksAsJsonString);
  return books;
}

void displayBook({required Book book}){
  
  print("""

Title: ${book.getTitle}
Author: ${book.getAuthor}
Genre: ${book.getGenre}
Publication Year: ${book.getPublicationYear}
""");

}
