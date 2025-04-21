import 'dart:io';
import 'dart:convert';

//Applying the concept of "encapsulation".
//First class: A Book class that displays the book information.
class Book{
  final int id;
  String _title;
  String _author;
  int _year;
  String _category;

// Constructor, initializer list for variables.
  Book(this.id, String title, String author, int year, String category)
  : _title =  title,
    _author = author,
    _year = year,
    _category = category;

// Getters, Provides external access to 'read' the private variable.
String get title => _title;
String get outhor => _author;
int get year => _year;
String get category => _category;

//Setter, Provides external access to 'modify' the private variable.
 set title(newTitle)=> _title = newTitle;
 set outhor (newOthor)=> _author = newOthor;
 set year (newYear)=> _year = newYear;
 set category (newCategory)=> _category = newCategory;

//View book information
 void display(){
print(' [$id] "$_title" by $_author ($_year) category: $_category');
 }
 
 
 // A function to search for books.
 // Returns true if the "title or author's name" matches the keyword.
 bool contains (String keyword){
  return
  _title.toLowerCase().contains(keyword.toLowerCase())||
  _author.toLowerCase().contains(keyword.toLowerCase());
 }

//
Map<String, dynamic> toJson() => {
        'id': id,
        'title': _title,
        'author': _author,
        'year': _year,
        'category': _category,
      };

  static Book fromJson(Map<String, dynamic> json) {
  return Book(json['id'], json['title'], json['author'], json['year'], json['category']);
  }
}

//Second class:
// Library class, manages all operations on books,(add-edit-delet-search-sort-save-load)
class Library {
final List<Book> _books = [];
int _nextId = 1;
final String _filePath = 'books.json';
 bool isArabic = true;

Library(){
  loadBooks();
}

void switchLanguage(){
  isArabic = !isArabic;
  print(isArabic ? 'تم التبديل إلى اللغة العربية' : 'Switched to English');
}

//Using an if-statement to check if there are any books.
void listBooks(){
  if (_books.isEmpty){
    print(isArabic ? ' لا توجد كتب حالياً.' : ' No books available');
  }else{
    print(isArabic ? ' قائمة الكتب:' : ' Book List:');
  }
  for(var book in _books){
  book.display();
  }
}

// A function to 'add' a new book to the library.
void addBook(){
print (isArabic ? 'أدخل عنوان الكتاب: ' : ' Enter book title: ');
String ? title = stdin.readLineSync();

print(isArabic ? ' أدخل اسم المؤلف: ' : ' Enter author name: ');
String ? author = stdin.readLineSync();

print(isArabic ? ' أدخل سنة النشر: ' : ' Enter publication year: ');
String ? yearInput = stdin.readLineSync();
int year = int.tryParse(yearInput ?? '') ?? 0;

print(isArabic ? ' أدخل التصنيف: ' : 'Enter category:');
String ? category = stdin.readLineSync();

if (title !=null && author != null && category != null && year > 0){
final book = Book(_nextId++, title, author, year, category);
_books.add(book);
 saveBooks();

 print(isArabic ? 'تم إضافة الكتاب بنجاح!' : ' Book added successfully!');
}else{
 print(isArabic ? ' بيانات غير صالحة!' : ' Invalid data!');
}
}

// A function to 'edit' a book in the library.
void editBook(){
  print(isArabic ? 'أدخل معرف الكتاب لتعديله: ' : ' Enter book ID to edit:');
  int id = int.tryParse(stdin.readLineSync()?? '')?? -1;
  Book? book = _books.any((b) => b.id == id)
    ? _books.firstWhere((b) => b.id == id)
    : null;
  

  if(book != null){
  print (isArabic ? 'العنوان الجديد (أو اضغط Enter للتخطي): ' : ' Enter New title, or press Enter to skip: ');
  String ? newTitle = stdin.readLineSync();
  if(newTitle != null && newTitle.isNotEmpty) book.title = newTitle;
  

  print (isArabic ? ' المؤلف الجديد (أو اضغط Enter للتخطي): ' : 'Enter New author, or press Enter to skip: ');
  String ? newAuthor = stdin.readLineSync();
  if (newAuthor != null && newAuthor.isNotEmpty) book.outhor= newAuthor;

  print(isArabic ? ' سنة النشر الجديدة (أو اضغط Enter للتخطي): ' : 'Enter New year, or press Enter to skip: ');
  String ? newYear = stdin.readLineSync();
  if(newYear != null && newYear.isNotEmpty){
    int? parsedYear = int.tryParse(newYear);
    if(parsedYear != null) book.year = parsedYear;
  }

  print(isArabic ? ' التصنيف الجديد (أو اضغط Enter للتخطي): ' : 'Enter New category, or press Enter to skip: ' );
  String ? newCategory = stdin.readLineSync();
  if(newCategory != null && newCategory.isNotEmpty) book.category = newCategory;

  saveBooks();
  print(isArabic ? ' تم تعديل الكتاب.' : ' Book updated.');
}else{
  print(isArabic ? 'لم يتم العثور على الكتاب.' : 'Book not found.');
}
}

// A function to 'delete' a book in the library.
void deleteBook(){
print(isArabic ? 'أدخل معرف الكتاب لحذفه: ' : 'Enter book ID to delete:');
int ? id = int.tryParse(stdin.readLineSync()?? '') ?? -1;
_books.removeWhere ((b) => b.id ==id);

 saveBooks();
 print(isArabic ? 'تم حذف الكتاب.' : 'Book deleted.');
}


// Searches the books in the library using a keyword entered by the user.
void searchBooks (){
  print (isArabic ? 'أدخل كلمة مفتاحية للبحث: ' : 'Enter search keyword:');
  String ? keyword = stdin.readLineSync();

  if(keyword !=null && keyword.isNotEmpty){
  List<Book> results = _books.where((book) => book.contains(keyword)).toList();

  if(results.isEmpty){
  print(isArabic ? ' لا توجد نتائج مطابقة.' : 'No matches found');
  }else{
    print(isArabic ? 'نتائج البحث:' : 'Search results:');
    for(var book in results){
    book.display();
    }
  }
  }else{
    print(isArabic ? 'كلمة البحث غير صالحة.' : 'Invalid keyword.');
  }
}

// A function that allows the user to sort the list of books.
void sortBook(){
  print(isArabic ? ' اختر طريقة الفرز:\n1. العنوان\n2. سنة النشر\n3. المؤلف\n4. التصنيف' : ' Choose sort method:\n1. Title\n2. Year\n3. Author\n4. Category');
  String ? choice = stdin.readLineSync();
  switch (choice){
    case '1':
    _books.sort((a,b) => a.title.compareTo(b.title));
    break;

    case '2':
    _books.sort((a,b) => a.year.compareTo(b.year));
    break;

    case '3':
    _books.sort((a,b) => a.outhor.compareTo(b.outhor));
    break;

    case '4':
    _books.sort((a,b) => a.category.compareTo(b.category));
    break;

    default:
    print (isArabic ? ' خيار غير صحيح.' : 'Invalid choice');
    return;
  }
  print(isArabic ? ' تم فرز الكتب.' : ' Books sorted');
  listBooks();
}

//Save and load books from a file by 'JSON'
void saveBooks(){
  final file = File(_filePath);
    List<Map<String, dynamic>> jsonBooks = _books.map((b) => b.toJson()).toList();
file.writeAsStringSync(jsonEncode(jsonBooks));
}

 void loadBooks() {
    final file = File(_filePath);
    if (file.existsSync()) {
      List<dynamic> jsonList = jsonDecode(file.readAsStringSync());
      _books.clear();
      for (var jsonBook in jsonList) {
        _books.add(Book.fromJson(jsonBook));
      }
      if (_books.isNotEmpty) {
        _nextId = _books.map((b) => b.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    }
  }

}

void main() {
  final library = Library();
  bool isRunning = true;

  while (isRunning) {
    print('\n=== 📖 Library Management System / نظام إدارة المكتبة ===');
    print('1. ${library.isArabic ? 'سرد الكتب' : 'List books'}');
    print('2. ${library.isArabic ? 'إضافة كتاب' : 'Add book'}');
    print('3. ${library.isArabic ? 'تعديل كتاب' : 'Edit book'}');
    print('4. ${library.isArabic ? 'البحث عن كتاب' : 'Search book'}');
    print('5. ${library.isArabic ? 'حذف كتاب' : 'Delete book'}');
    print('6. ${library.isArabic ? 'فرز الكتب' : 'Sort books'}');
    print('7. ${library.isArabic ? 'تبديل اللغة' : 'Switch language'}');
    print('8. ${library.isArabic ? 'خروج' : 'Exit'}');

    stdout.write(library.isArabic ? 'اختر رقم الإجراء: ' : 'Choose an action number: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        library.listBooks();
        break;
      case '2':
        library.addBook();
        break;
      case '3':
        library.editBook();
        break;
      case '4':
        library.searchBooks();
        break;
      case '5':
        library.deleteBook();
        break;
      case '6':
        library.sortBook();
        break;
      case '7':
        library.switchLanguage();
        break;
      case '8':
        isRunning = false;
        print(library.isArabic ? 'إلى اللقاء!' : ' Goodbye!');
        break;
      default:
        print(library.isArabic ? 'إدخال غير صالح.' : ' Invalid input!');
    }
  }
}

