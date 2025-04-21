import 'dart:io' as io;
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as p;

bool ifArabic = false;

class Book {
  String? _bookName;
  String? _author;
  String? _year;
  String? _id;
  String? _catagory;

  Book(String id, String name, String author, String catagory, String year) {
    this._bookName = name;
    this._author = author;
    this._year = year;
    this._id = id;
    this._catagory = catagory;
  }

  void setBookName(String name) {
    this._bookName = name;
  }

  void setAuthor(String author) {
    this._author = author;
  }

  void setYear(String year) {
    this._year = year;
  }

  void setId(String id) {
    this._id = id;
  }

  void setCatagory(String catagory) {
    this._catagory = catagory;
  }

  String? getCatagory() {
    return _catagory;
  }

  String? getId() {
    return _id;
  }

  String? getBookName() {
    return _bookName;
  }

  String? getAuthor() {
    return _author;
  }

  String? getYear() {
    return _year;
  }

  void printer() {
    print(
      'Id:${getId()} Name:${getBookName()} Author:${getAuthor()} Catagory:${getCatagory()} Year:${getYear()}',
    );
  }

  void printerAr() {
    print(
      'ﻑﺮﻌﻤﻟﺍ:${getId()} ﻢﺳﻹﺍ:${getBookName()} ﺐﺗﺎﻜﻟﺍ:${getAuthor()} ﻒﻴﻨﺼﺘﻟﺍ:${getCatagory()} ﺭﺍﺪﺻﻹﺍ ﺔﻨﺳ:${getYear()}',
    );
  }

  String? printerForFile() {
    return 'Id:${getId()} Name:${getBookName()} Author:${getAuthor()} Catagory:${getCatagory()} Year:${getYear()}';
  }
}


void main() async {
  Book book = Book('1', 'Tech', 'Dr.Mohammed', 'Educational', '2004');
  Book book1 = Book('2', 'Math', 'Ayman', 'Educational', '2005');
  Book book2 = Book('3', 'How to raise a cat', 'Dr.Cat', 'Drama', '2007');

  List<Book> booksa = [book1, book2, book];

  int userInput = 0;
  int userInputAr = 0;
  do {
    print('please make a choice');
    print('1-view available books');
    print('2-add book');
    print('3-remove book');
    print('4-update book');
    print('5-search book');
    print('6-sort books by year');
    print('7-save Book List');
    print('8-Read saved file');
    print('9-exit');
    print("10-ﺔﻴﺑﺮﻌﻟﺍ ﺔﻐﻠﻟﺍ");

    ifArabic = false;
    try {
      userInput = int.parse(io.stdin.readLineSync()!);
      switch (userInput) {
        case 1:
          {
            printAll(booksa);
            break;
          }
        case 2:
          {
            addBook(booksa);
            break;
          }

        case 3:
          printAll(booksa);
          removeBook(booksa);
          break;

        case 4:
          {
            print('Choose a book to edit by Id');
            printAll(booksa);
            editBook(booksa);
          }
        case 5:
          {
            print('Search by author name');
            searchBook(booksa);
          }
        case 6:
          {
            print('Book is sorted by Year');
            toSort(booksa);
          }
        case 7:
          {
            final filename = 'file.txt';
            var file = await io.File(
              filename,
            ).writeAsString(printFlie(booksa)!);
          }
        case 8:
          {
            File file = File('file.txt');
            String contents = file.readAsStringSync();
            print(contents);
          }
        case 9:
          io.exit(0);

        case 10:
          {
            do {
              print('ﻢﻗﺭ ﺭﺎﻴﺘﺧﺍ ﺍﻮﺟﺭﺍ');
              print('1-ﺔﺒﺘﻜﻤﻟﺍ ﺽﺮﻋ');
              print('2-ﺏﺎﺘﻛ ﺔﻓﺎﺿﺍ');
              print('3-ﺏﺎﺘﻛ ﻑﺬﺣ');
              print('4-ﺏﺎﺘﻛ ﺚﻳﺪﺤﺗ');
              print('5-ﺏﺎﺘﻛ ﻦﻋ ﺚﺤﺒﻟﺍ');
              print('6-ﺕﺍﻮﻨﺴﻟﺍ ﺐﺴﺣ ﺐﺘﻜﻟﺍ ﺐﻴﺗﺮﺗ');
              print('7-ﺔﺒﺘﻜﻤﻟﺍ ﻆﻔﺣ');
              print('8-ﺔﻇﻮﻔﺤﻤﻟﺍ ﺔﺒﺘﻜﻤﻟﺍ ﺽﺮﻋ');
              print('9-ﺝﻭﺮﺧ');
              print('10-English');
              ifArabic = true;

              try {
                userInputAr = int.parse(io.stdin.readLineSync()!);
                switch (userInputAr) {
                  case 1:
                    {
                      printAll(booksa);
                      break;
                    }
                  case 2:
                    {
                      ifArabic = true;
                      addBook(booksa);
                      break;
                    }

                  case 3:
                    printAll(booksa);
                    removeBook(booksa);
                    break;

                  case 4:
                    {
                      print('ﻑﺮﻌﻤﻟﺍ ﻦﻣ ﺏﺎﺘﻛ ﺮﺘﺧﺍ');
                      printAll(booksa);
                      editBook(booksa);
                    }
                  case 5:
                    {
                      print('ﺐﺗﺎﻜﻟﺍ ﻢﺳﺈﺑ ﺏﺎﺘﻜﻟﺍ ﻦﻋ ﺚﺤﺒﻟﺍ');
                      searchBook(booksa);
                    }
                  case 6:
                    {
                      print('ﺔﻨﺴﻟﺍ ﺐﺴﺣ ﺐﺘﻜﻟﺍ ﺐﻴﺗﺮﺗ ﻢﺗ');
                      toSort(booksa);
                    }
                  case 7:
                    {
                      final filename = 'file.txt';
                      var file = await io.File(
                        filename,
                      ).writeAsString(printFlie(booksa)!);
                    }
                  case 8:
                    {
                      File file = File('file.txt');
                      String contents = file.readAsStringSync();
                      print(contents);
                    }
                  case 9:
                    io.exit(0);
                }
              } catch (e) {
                print('ﺢﻴﺤﺻ ﻢﻗﺭ ﻝﺎﺧﺩﺍ ﺀﺎﺟﺮﻟﺍ');
              }
            } while (userInputAr != 10);
          }
      }
    } catch (e) {
      print('Please enter a valid number');
    }
  } while (userInput != 9);

  book.setAuthor('ayman');
}

//اضافة كتاب والتأكد من عدم وجود تكرار في الآيدي والتأكد من انه التاريخ والايدي رقم
void addBook(List<Book> book) {
  Book newBook = Book('', '', '', '', '');

  if (ifArabic == false) {
    print('Pleae enter a name for the book');
    newBook.setBookName(io.stdin.readLineSync()!);
    print('Pleae enter an author for the book');
    newBook.setAuthor(io.stdin.readLineSync()!);
    print('Pleae enter a catagory for the book');
    newBook.setCatagory(io.stdin.readLineSync()!);
    print('Pleae enter a year for the book');
    while (isNumeric(newBook.getYear()!) == false) {
      newBook.setYear(io.stdin.readLineSync()!);

      if (isNumeric(newBook.getYear()!) == false) {
        print('plese enter a valid number');
      }
    }
    print('Plese enter Id for the book');
    while (isNumeric(newBook.getId()!) == false) {
      newBook.setId(io.stdin.readLineSync()!);
      if (isNumeric(newBook.getId()!) == false) {
        print('plese enter a valid number');
      }
    }

    if (!isExist(book, newBook.getId()!)!) {
      book.add(newBook);
      print('Book was added');
    } else {
      print('The book name or id already in the library');
    }
  } else {
    print('ﺏﺎﺘﻜﻟﺍ ﻢﺳﺍ ﻞﺧﺩﺍ');
    newBook.setBookName(io.stdin.readLineSync()!);
    print('ﺐﺗﺎﻜﻟﺍ ﻢﺳﺍ ﻞﺧﺩﺍ');
    newBook.setAuthor(io.stdin.readLineSync()!);
    print('ﺏﺎﺘﻜﻟﺍ ﻒﻴﻨﺼﺗ ﻞﺧﺩﺍ');
    newBook.setCatagory(io.stdin.readLineSync()!);
    print('ﺏﺎﺘﻜﻠﻟ ﺭﺍﺪﺻﻹﺍ ﺦﻳﺭﺎﺗ ﻞﺧﺩﺍ');
    while (isNumeric(newBook.getYear()!) == false) {
      newBook.setYear(io.stdin.readLineSync()!);

      if (isNumeric(newBook.getYear()!) == false) {
        print('ﺢﻴﺤﺻ ﻢﻗﺭ ﻝﺎﺧﺩﺍ ﺀﺎﺟﺮﻟﺍ');
      }
    }
    print('ﺏﺎﺘﻜﻠﻟ ﻑﺮﻌﻣ ﻝﺎﺧﺩﺍ ﺀﺎﺟﺮﻟﺍ');
    while (isNumeric(newBook.getId()!) == false) {
      newBook.setId(io.stdin.readLineSync()!);
      if (isNumeric(newBook.getId()!) == false) {
        print('ﺢﻴﺤﺻ ﻢﻗﺭ ﻝﺎﺧﺩﺍ ﺀﺎﺟﺮﻟﺍ');
      }
    }

    if (!isExist(book, newBook.getId()!)!) {
      book.add(newBook);
      print('ﺏﺎﺘﻜﻟﺍ ﺔﻓﺎﺿﺇ ﻢﺗ');
    } else {
      print('ﻞﻌﻔﻟﺎﺑ ﺩﻮﺟﻮﻣ ﺏﺎﺘﻜﻟﺍ');
    }
  }
}

// يطبع جميع الكتب الموجودة في المكتبة
void printAll(List books) {
  for (var item in books) {
    if (ifArabic == false) {
      item.printer();
    } else {
      item.printerAr();
    }
  }
}

// حذف الكتاب من المكتبة
void removeBook(List<Book> books) {

  if(ifArabic == false){
  print('choose the the book Id');
  }
  else{
    print('ﻪﻓﺬﺤﻟ ﺏﺎﺘﻜﻟﺍ ﻑﺮﻌﻣ ﺮﺘﺧﺍ');
  }
  String? bookRemove = io.stdin.readLineSync();

  int itrationNum = 0;
  bool founded = false;

  for (var item in books) {
    itrationNum++;
    if (item.getId() == bookRemove) {
      books.removeAt(itrationNum - 1);
      founded = true;
      if(ifArabic == false){
      print('The Book ${item.getBookName()} Have been removed');
      }
      else{
      print('ﺏﺎﺘﻜﻟﺍ ${item.getBookName()} ﻪﻓﺬﺣ ﻢﺗ');
      }
            break;

    }
  }

 if(ifArabic == false){
  if (!founded) {
    print('Book not found');
  
  }
  }
   else{
  if (!founded) {
    print('ﺏﺎﺘﻜﻟﺍ ﻰﻠﻋ ﺭﻮﺜﻌﻟﺍ ﻢﺘﻳ ﻢﻟ');
  
  }
  }
}

//تعديل معلومات كتاب
void editBook(List<Book> books) {
  String? bookId = io.stdin.readLineSync();

  bool founded = false;

  for (var item in books) {
    if (ifArabic == false) {
      if (item.getId() == bookId) {
        print('what do you want to change?');
        print('1- Book name');
        print('2- author name');
        print('3- catagory name');
        print('4- year');
        int userUpdateBook = int.parse(io.stdin.readLineSync()!);
        founded = true;

        switch (userUpdateBook) {
          case 1:
            {
              print('Enter new Name for the book');
              item.setBookName(io.stdin.readLineSync()!);
            }
          case 2:
            {
              print('Enter new Author for the book');
              item.setAuthor(io.stdin.readLineSync()!);
            }
          case 3:
            {
              print('Enter new Catagory for the book');
              item.setCatagory(io.stdin.readLineSync()!);
            }
          case 4:
            {
              do {
                print('Enter new Year');
                item.setYear(io.stdin.readLineSync()!);

                if (isNumeric(item.getYear()!) == false) {
                  print('plese enter a valid number');
                }
              } while (isNumeric(item.getYear()!) == false);
            }
        }
      }
    }
    else{

    if (item.getId() == bookId) {
        print('ﺮﻴﻴﻐﺘﻟﺍ ﺪﻳﺮﺗ ﺍﺫﺎﻣ?');
        print('1- ﺏﺎﺘﻜﻟﺍ ﻢﺳﺍ');
        print('2- ﺐﺗﺎﻜﻟﺍ ﻢﺳﺍ');
        print('3- ﻒﻴﻨﺼﺘﻟﺍ');
        print('4- ﺭﺍﺪﺻﻹﺍ ﺔﻨﺳ');
        int userUpdateBook = int.parse(io.stdin.readLineSync()!);
        founded = true;

        switch (userUpdateBook) {
          case 1:
            {
              print('ﺪﻳﺪﺠﻟﺍ ﺏﺎﺘﻜﻟﺍ ﻢﺳﺍ ﻞﺧﺩﺍ');
              item.setBookName(io.stdin.readLineSync()!);
            }
          case 2:
            {
              print('ﺪﻳﺪﺠﻟﺍ ﺐﺗﺎﻜﻟﺍ ﻢﺳﺍ ﻞﺧﺩﺍ');
              item.setAuthor(io.stdin.readLineSync()!);
            }
          case 3:
            {
              print('ﺪﻳﺪﺠﻟﺍ ﺏﺎﺘﻜﻟﺍ ﻒﻴﻨﺼﺗ ﻞﺧﺩﺍ');
              item.setCatagory(io.stdin.readLineSync()!);
            }
          case 4:
            {
              do {
                print('ﺓﺪﻳﺪﺠﻟﺍ ﺔﻨﺴﻟﺍ ﻞﺧﺩﺍ');
                item.setYear(io.stdin.readLineSync()!);

                if (isNumeric(item.getYear()!) == false) {
                  print('ﺢﻟﺎﺻ ﻢﻗﺭ ﻝﺎﺧﺩﺍ ﺀﺎﺟﺮﻟﺍ');
                }
              } while (isNumeric(item.getYear()!) == false);
            }
        }
      }


    }
  }
  
  if(ifArabic == false){
  if (!founded) {
    print('Book not found');
  
  }
  }
   else{
  if (!founded) {
    print('ﺏﺎﺘﻜﻟﺍ ﻰﻠﻋ ﺭﻮﺜﻌﻟﺍ ﻢﺘﻳ ﻢﻟ');
  
  }
  }
}

//البحث عن كتاب من اسم الكاتب
void searchBook(List<Book> books) {
  String? authorName = io.stdin.readLineSync();

  for (var item in books) {
    if (item.getAuthor() == authorName) {
      if(ifArabic == false){
      item.printer();
      }
      else{
        item.printerAr();
      }
    }
  }
}

// ترتيب الكتب حسب التاريخ
void toSort(List<Book> books) {
  books.sort((a, b) {
    int test = int.parse(a.getYear()!).compareTo(int.parse(b.getYear()!));
    return test;
  });
}

//التحقق من الكتاب موجود او لا
bool? isExist(List<Book> books, String boo) {
  for (var item in books) {
    if (item.getId() == boo) {
      return true;
    }
  }
  return false;
}

//يطبع المكتبه لفايل تيكست
String? printFlie(List<Book> books) {
  List<String> lst = [];

  for (var item in books) {
    lst.add('${item.printerForFile()}\n');
  }

  return lst.toString();
}

// يتأكد هل المدخل رقم
bool isNumeric(String year) {
  if (year == null) {
    return false;
  }
  return double.tryParse(year) != null;
}
