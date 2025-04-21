import 'dart:io';
import 'dart:convert';
// book class
class Book {
  // the variables
  int id;
  String title;
  String author;
  int year;
  String genre;
  //class constructor 
  Book(this.id, this.title, this.author, this.year, this.genre);
  // recive and convert from json function
  Book.convertFromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        year = json['year'],
        genre = json['genre'];
//send and convert to json function
  Map<String, dynamic> convertToJson() => {
        'id': id,
        'title': title,
        'author': author,
        'year': year,
        'genre': genre,
      };
// change the way of provide the data
  @override
  String toString() {
    return '[$id] "$title" by $author ($year) - $genre';
  }
}
// list of books
List<Book> books = [];
// id of starting for books
int nextId = 1;
// json file thats store the books details
final String fileName = 'books.json';

// main function
void main(){
  //chooseing language
print('select a language ar / en');
String? selected = stdin.readLineSync();
// if statement to redirct the program to arabic functions or english functions
if (selected == 'ar'){
  mainAr();
}else if(selected == 'en'){
  mainEn();
}
// redirct to the main if the choice is not true
else{
print('please select from the choices');
main();
}
}
//main for english language
mainEn () async{
print('\n Main Menu');
print('1- List all books');
print('2- Add new book');
print('3- Edit book');
print('4- Search book');
print('5- Delete book');
print('6- Sort books');
print('7- Exit');
print('choose a option: ');
String? input = stdin.readLineSync();
// switch for choose the right function
switch (input) {
      case '1':
        listBooks();
        break;
      case '2':
        await addBook();
        break;
      case '3':
        await editBook();
        break;
      case '4':
        searchBook();
        break;
      case '5':
        await deleteBook();
        break;
      case '6':
        await sortBooks();
        break;
      case '7':
        print('good bye -_-');
        return;
        // if the choice not true go back to mainEnglish function
      default:
        print('please select true option');
        mainEn();
    }
  }
  //arabic main function
  mainAr() async{
print('\n القائمة الرئيسية');
print('1- عرض كل الكتب');
print('2- اضافة كتاب جديد');
print('3- تعديل كتاب');
print('4- البحث عن كتاب');
print('5- حذف كتاب');
print('6- ترتيب الكتب');
print('7- خروج');
print('اختر من الخيارات السابقة: ');
String? input = stdin.readLineSync();
// the switch for arabic main function
switch (input) {
      case '1':
        listBooksAr();
        break;
      case '2':
        await addBookAr();
        break;
      case '3':
        await editBookAr();
        break;
      case '4':
        searchBookAr();
        break;
      case '5':
        await deleteBookAr();
        break;
      case '6':
        await sortBooksAr();
        break;
      case '7':
        print('وداعا -_-');
        return;
      default:
        print('رجاء اختر خيار صحيح');
        mainAr();
    }
}
//english function for list all the book
void listBooks()async{
  await loadBooks();
  if (books.isEmpty) {
    print('No books');
    mainEn();
  } else {
    for (var book in books) {
      print(book);
    }
    mainEn();
  }
}
//arabic function for list all the book
void listBooksAr() async{
  await loadBooks();
  if (books.isEmpty) {
    print('لايوجد كتب');
    mainAr();
  } else {
    for (var book in books) {
      print(book);
    }
    mainAr();
  }
}
//english function to add book 
Future<void> addBook() async {
  stdout.write('Title: ');
  String? title = stdin.readLineSync();
  stdout.write('Author: ');
  String? author = stdin.readLineSync();
  stdout.write('Year: ');
  int? year = int.tryParse(stdin.readLineSync() ?? '');
  stdout.write('Genre: ');
  String? genre = stdin.readLineSync();
  if (title != null && author != null && year != null && genre != null) {
    bool exists = books.any((b) => b.title == title && b.author == author);
    if (exists) {
      print('This book already exists');
      mainEn();
    } else {
      books.add(Book(nextId++, title, author, year, genre));
      await saveBooks();
      print('Book inserted');
      mainEn();
    }
  } else {
    print('Incomplete input');
    mainEn();
  }
}
//arabic function to add book 
Future<void> addBookAr() async {
  stdout.write('العنوان: ');
  String? title = stdin.readLineSync();
  stdout.write('المؤلف: ');
  String? author = stdin.readLineSync();
  stdout.write('سنة النشر: ');
  int? year = int.tryParse(stdin.readLineSync() ?? '');
  stdout.write('التصنيف: ');
  String? genre = stdin.readLineSync();
  if (title != null && author != null && year != null && genre != null) {
    bool exists = books.any((b) => b.title == title && b.author == author);
    if (exists) {
      print('هذا الكتاب موجود بالفعل');
      mainAr();
    } else {
      books.add(Book(nextId++, title, author, year, genre));
      await saveBooks();
      print('تم اضافة الكتاب بنجاح');
      mainAr();
    }
  } else {
    print('خطأ اثناء اضافة الكتاب');
    mainAr();
  }
}
// english function to edit a book 
Future<void> editBook() async {
  stdout.write('Book ID: ');
  int? id = int.tryParse(stdin.readLineSync() ?? '');
  var book = books.firstWhere((b) => b.id == id, orElse: () => Book(-1, '', '', 0, ''));
  if (book.id == -1) {
    print('Book not found _-_');
    return;
  }
  stdout.write('New title (optional): ');
  String? newTitle = stdin.readLineSync();
  if (newTitle != null && newTitle.isNotEmpty) book.title = newTitle;
  stdout.write('New author (optional): ');
  String? newAuthor = stdin.readLineSync();
  if (newAuthor != null && newAuthor.isNotEmpty) book.author = newAuthor;
  stdout.write('New year (optional): ');
  int? newYear = int.tryParse(stdin.readLineSync() ?? '');
  if (newYear != null) book.year = newYear;
  stdout.write('New genre (optional): ');
  String? newGenre = stdin.readLineSync();
  if (newGenre != null && newGenre.isNotEmpty) book.genre = newGenre;
  await saveBooks();
  print('Book updated');
  mainEn();
}
// arabic function to edit a book 
Future<void> editBookAr() async {
  stdout.write('ادخل رقم الكتاب: ');
  int? id = int.tryParse(stdin.readLineSync() ?? '');
  var book = books.firstWhere((b) => b.id == id, orElse: () => Book(-1, '', '', 0, ''));
  if (book.id == -1) {
    print('لم يتم العثور على الكتاب  _-_');
    return;
  }
  stdout.write('العنوان الجديد :(اختياري) ');
  String? newTitle = stdin.readLineSync();
  if (newTitle != null && newTitle.isNotEmpty) book.title = newTitle;
  stdout.write('المؤلف الجديد (اختياري): ');
  String? newAuthor = stdin.readLineSync();
  if (newAuthor != null && newAuthor.isNotEmpty) book.author = newAuthor;
  stdout.write('سنة النشر الجديدة (اختياري): ');
  int? newYear = int.tryParse(stdin.readLineSync() ?? '');
  if (newYear != null) book.year = newYear;
  stdout.write('التصنيف الجديد (اختياري): ');
  String? newGenre = stdin.readLineSync();
  if (newGenre != null && newGenre.isNotEmpty) book.genre = newGenre;
  await saveBooks();
  print('تم تعديل الكتاب بنجاح');
  mainAr();
}
//english function to search for a book
void searchBook() {
  stdout.write('Search keyword: ');
  String? keyword = stdin.readLineSync();
  if (keyword == null || keyword.isEmpty) return;
  var results = books.where((b) =>
      b.title.toLowerCase().contains(keyword.toLowerCase()) ||
      b.author.toLowerCase().contains(keyword.toLowerCase())).toList();
  if (results.isEmpty) {
    print('No matching books found');
    mainEn();
  } else {
    results.forEach(print);
    mainEn();
  }
}
//arabic function to search for a book
void searchBookAr() {
  stdout.write('ادخل كلمة للبحث: ');
  String? keyword = stdin.readLineSync();
  if (keyword == null || keyword.isEmpty) return;
  var results = books.where((b) =>
      b.title.toLowerCase().contains(keyword.toLowerCase()) ||
      b.author.toLowerCase().contains(keyword.toLowerCase())).toList();
  if (results.isEmpty) {
    print('لا توجد نتائج');
    mainAr();
  } else {
    results.forEach(print);
    mainAr();
  }
}
//english function for delete a book
Future<void> deleteBook() async {
  stdout.write('Book ID: ');
  int? id = int.tryParse(stdin.readLineSync() ?? '');
  books.removeWhere((b) => b.id == id);
  await saveBooks();
  print('Book deleted');
  mainEn();
}
//arabic function for delete a book
Future<void> deleteBookAr() async {
  stdout.write('ادخل رقم الكتاب: ');
  int? id = int.tryParse(stdin.readLineSync() ?? '');
  books.removeWhere((b) => b.id == id);
  await saveBooks();
  print('تم حذف الكتاب');
  mainAr();
}
//english function for sorting the books
Future<void> sortBooks() async {
  stdout.write('Sort by (title/year): ');
  String? by = stdin.readLineSync();
  if (by == 'title') {
    books.sort((a, b) => a.title.compareTo(b.title));
  } else if (by == 'year') {
    books.sort((a, b) => a.year.compareTo(b.year));
  }
  await saveBooks();
  print('Books sorted');
  mainEn();
}
//arabic function for sorting the books
Future<void> sortBooksAr() async {
  stdout.write('رتب بواسطة -> العنوان / سنة النشر: ');
  String? by = stdin.readLineSync();
  if (by == 'العنوان') {
    books.sort((a, b) => a.title.compareTo(b.title));
  } else if (by == 'سنة النشر') {
    books.sort((a, b) => a.year.compareTo(b.year));
  }
  await saveBooks();
  print('تم الترتيب');
  mainAr();
}
//the function to save the books in json file for both language
Future<void> saveBooks() async {
  final file = File(fileName);
  await file.writeAsString(jsonEncode(books.map((b) => b.convertToJson()).toList()));
}
//the function to load the books from json file for both language
Future<void> loadBooks() async {
  final file = File(fileName);
  if (await file.exists()) {
    final content = await file.readAsString();
    final List<dynamic> jsonData = jsonDecode(content);
    books = jsonData.map((e) => Book.convertFromJson(e)).toList();
    nextId = books.isEmpty ? 1 : books.map((b) => b.id).reduce((a, b) => a > b ? a : b) + 1;
  } else {
    books = [];
    nextId = 1;
  }
}
