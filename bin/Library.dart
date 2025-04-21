import 'dart:io';
import 'dart:convert';

// Book class
class Book {
  int id;
  String title;
  String author;
  int year;
  String category;

  Book(this.id, this.title, this.author, this.year, this.category);

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'author': author,
    'year': year,
    'category': category,
  };

  static Book fromJson(Map<String, dynamic> json) => Book(
    json['id'],
    json['title'],
    json['author'],
    json['year'],
    json['category'],
  );

  // English & Arabic representation
  String toString() {
    if (lang == 'ar') {
      String rTitle = fixRtl(title);
      String rAuthor = fixRtl(author);
      String rCategory = fixRtl(category);
      return '$id:${msg('idLabel')} | $rTitle: ${msg('titleLabel')} | $rAuthor : ${msg('authorLabel')} | $year : ${msg('yearLabel')} | $rCategory : ${msg('categoryLabel')}';
    } else if (lang == 'en') {
      return '${msg('idLabel')}: $id | ${msg('titleLabel')}: $title | ${msg('authorLabel')}: $author | ${msg('yearLabel')}: $year | ${msg('categoryLabel')}: $category';
    } else {
      return "No Languge Used";
    }
  }
}

// revrese and mix Arabic language
String fixRtl(String text) {
  if (lang == 'ar') {
    return text
        .split('\n')
        .map((line) => line.split('').reversed.join())
        .join('\n');
  }
  return text;
}

// Global state
List<Book> library = [];
int nextId = 1;
String lang = 'en';

// menu stored mesages in map
Map<String, Map<String, String>> messages = {
  'en': {
    'menu': '''
Book Library Menu:
1. List all books
2. Add a book
3. Edit a book
4. Search for a book
5. Delete a book
6. Save books
7. Load books
8. Sort books
9. Switch language
10. Exit
Enter your choice:
''',
    'enterTitle': 'Enter book title:',
    'enterAuthor': 'Enter author name:',
    'enterYear': 'Enter publication year:',
    'enterCategory': 'Enter book category:',
    'added': 'Book added successfully!',
    'duplicate': 'This book already exists!',
    'invalid': 'Invalid input.',
    'listEmpty': 'No books in the library.',
    'searchKeyword': 'Enter keyword (title or author):',
    'noResults': 'No matching books found.',
    'editId': 'Enter ID of the book to edit:',
    'editDone': 'Book updated.',
    'deleteId': 'Enter ID of the book to delete:',
    'deleted': 'Book deleted.',
    'notFound': 'Book not found.',
    'saveSuccess': 'Books saved to file.',
    'loadSuccess': 'Books loaded from file.',
    'sortChoice': 'Sort by:\n1. Title\n2. Year',
    'languageSwitched': 'Language switched to English.',
    'goodbye': 'Goodbye!',
    'idLabel': 'ID',
    'titleLabel': 'Title',
    'authorLabel': 'Author',
    'yearLabel': 'Year',
    'categoryLabel': 'Category',
  },
  'ar': {
    'menu': '''
:ﺐﺘﻜﻟﺍ ﺔﺒﺘﻜﻣ ﺔﻤﺋﺎﻗ
ﺐﺘﻜﻟﺍ ﻊﻴﻤﺟ ﺽﺮﻋ .1
ﺏﺎﺘﻛ ﺔﻓﺎﺿﺇ .2
ﺏﺎﺘﻛ ﻞﻳﺪﻌﺗ .3
ﺏﺎﺘﻛ ﻦﻋ ﺚﺤﺒﻟﺍ .4
ﺏﺎﺘﻛ ﻑﺬﺣ .5
ﺐﺘﻜﻟﺍ ﻆﻔﺣ .6
ﺐﺘﻜﻟﺍ ﻞﻴﻤﺤﺗ .7
ﺐﺘﻜﻟﺍ ﺐﻴﺗﺮﺗ .8
ﺔﻐﻠﻟﺍ ﺮﻴﻴﻐﺗ .9
ﺝﻭﺮﺧ .10
:ﻙﺭﺎﻴﺘﺧﺍ ﻞﺧﺩﺃ 

''',
    'enterTitle': ':ﺏﺎﺘﻜﻟﺍ ﻥﺍﻮﻨﻋ ﻞﺧﺩﺃ',
    'enterAuthor': ':ﻒﻟﺆﻤﻟﺍ ﻢﺳﺍ ﻞﺧﺩﺃ',
    'enterYear': ':ﺮﺸﻨﻟﺍ ﺔﻨﺳ ﻞﺧﺩﺃ',
    'enterCategory': ':ﺏﺎﺘﻜﻟﺍ ﻉﻮﻧ ﻞﺧﺩﺃ',
    'added': '! ﺏﺎﺘﻜﻟﺍ ﺔﻓﺎﺿﺇ ﺖﻤﺗ',
    'duplicate': '! ﻞﻌﻔﻟﺎﺑ ﺩﻮﺟﻮﻣ ﺏﺎﺘﻜﻟﺍ',
    'invalid': '.ﺢﻟﺎﺻ ﺮﻴﻏ ﻝﺎﺧﺩﺇ',
    'listEmpty': '. ﺐﺘﻛ ﺪﺟﻮﺗ ﻻ',
    'searchKeyword': ': ﻒﻟﺆﻤﻟﺍ ﻭﺃ ﻥﺍﻮﻨﻌﻟﺍ ﻞﺧﺩﺃ ',
    'noResults': '. ﺐﺘﻛ ﻰﻠﻋ ﺭﻮﺜﻌﻟﺍ ﻢﺘﻳ ﻢﻟ',
    'editId': ': ﻞﻳﺪﻌﺘﻠﻟ ﺏﺎﺘﻜﻟﺍ ﻢﻗﺭ ﻞﺧﺩﺃ',
    'editDone': '. ﺏﺎﺘﻜﻟﺍ ﻞﻳﺪﻌﺗ ﻢﺗ',
    'deleteId': ': ﻑﺬﺤﻠﻟ ﺏﺎﺘﻜﻟﺍ ﻢﻗﺭ ﻞﺧﺩﺃ',
    'deleted': '. ﺏﺎﺘﻜﻟﺍ ﻑﺬﺣ ﻢﺗ',
    'notFound': '. ﺩﻮﺟﻮﻣ ﺮﻴﻏ ﺏﺎﺘﻜﻟﺍ',
    'saveSuccess': '. ﺐﺘﻜﻟﺍ ﻆﻔﺣ ﻢﺗ',
    'loadSuccess': '. ﺐﺘﻜﻟﺍ ﻞﻴﻤﺤﺗ ﻢﺗ',
    'sortChoice': 'ﺮﺸﻨﻟﺍ ﺔﻨﺳ .2  ﻥﺍﻮﻨﻌﻟﺍ .1:ﺐﺴﺣ ﺐﺗﺮﺒﺗ',
    'languageSwitched': '.ﺔﻴﺑﺮﻌﻟﺍ ﺔﻐﻠﻟﺍ ﻰﻟﺍ ﻞﻳﺪﺒﺘﻟﺍ ﻢﺗ',
    'goodbye': '! ﺔﻣﻼﺴﻟﺍ ﻊﻣ',
    'idLabel': 'ﻑّﺮﻌﻣ',
    'titleLabel': 'ﻥﺍﻮﻨﻌﻟﺍ',
    'authorLabel': 'ﻒﻟﺆﻤﻟﺍ',
    'yearLabel': 'ﺔﻨﺴﻟﺍ',
    'categoryLabel': 'ﺔﺌﻔﻟﺍ',
  },
};
// direction message for for choosen languge
String msg(String key) => messages[lang]![key]!;

// Input helpers
int? readInt(String prompt) {
  print(prompt);
  var input = stdin.readLineSync();
  return int.tryParse(input ?? '');
}

// Add book
void addBook() {
  print(msg('enterTitle'));
  String title = stdin.readLineSync(encoding: utf8)!.trim();
  print(msg('enterAuthor'));
  String author = stdin.readLineSync(encoding: utf8)!.trim();
  int? year = readInt(msg('enterYear'));
  print(msg('enterCategory'));
  String category = stdin.readLineSync(encoding: utf8)!.trim();

  if (year == null || title.isEmpty || author.isEmpty) {
    print(msg('invalid'));
    return;
  }

  // Prevent duplicate entries
  bool exists = library.any(
    (book) =>
        book.title.toLowerCase() == title.toLowerCase() &&
        book.author.toLowerCase() == author.toLowerCase(),
  );

  if (exists) {
    print(msg('duplicate'));
    return;
  }

  library.add(Book(nextId++, title, author, year, category));
  print(msg('added'));
}

// List books
void listBooks() {
  if (library.isEmpty) {
    print(msg('listEmpty'));
  } else {
    for (var book in library) {
      print(book);
    }
  }
}

// Search
void searchBooks() {
  print(msg('searchKeyword'));
  String keyword = stdin.readLineSync(encoding: utf8)!.toLowerCase();
  var results = library.where(
    (book) =>
        book.title.toLowerCase().contains(keyword) ||
        book.author.toLowerCase().contains(keyword),
  );
  results.isEmpty
      ? print(msg('noResults'))
      : results.forEach((book) => print(book));
}

// Edit
void editBook() {
  int? id = readInt(msg('editId'));
  if (id == null) return;

  Book? book;
  try {
    book = library.firstWhere((b) => b.id == id);
  } catch (e) {
    book = null;
  }

  if (book == null) {
    print(msg('notFound'));
    return;
  }

  print('${msg('enterTitle')} (${book.title}):');
  String? title = stdin.readLineSync(encoding: utf8);
  print('${msg('enterAuthor')} (${book.author}):');
  String? author = stdin.readLineSync(encoding: utf8);
  int? year = readInt('${msg('enterYear')} (${book.year}):');
  print('${msg('enterCategory')} (${book.category}):');
  String? category = stdin.readLineSync(encoding: utf8);

  if (title != null && title.isNotEmpty) book.title = title;
  if (author != null && author.isNotEmpty) book.author = author;
  if (year != null) book.year = year;
  if (category != null && category.isNotEmpty) book.category = category;

  print(msg('editDone'));
}

// Delete a book
void deleteBook() {
  int? id = readInt(msg('deleteId'));
  if (id == null) {
    print(msg('noResults'));
    return;
  }

  int initialLength = library.length;
  library.removeWhere((book) => book.id == id);
  if (library.length < initialLength) {
    print(msg("deleted"));
  } else {
    print(msg('notFound'));
  }
}

// Save to file
void saveBooks() {
  File file = File("file.txt");
  List jsonList = library.map((book) => book.toJson()).toList();
  file.writeAsStringSync(jsonEncode(jsonList));
  print(msg('saveSuccess'));
}

// Load from file
void loadBooks() {
  File file = File("file.txt");
  if (file.existsSync()) {
    String content = file.readAsStringSync(encoding: utf8);
    List list = jsonDecode(content);
    library = list.map((e) => Book.fromJson(e)).toList();
    nextId = library.map((b) => b.id).fold(0, (a, b) => a > b ? a : b) + 1;
    print(msg('loadSuccess'));
  }
}

// Sort books
void sortBooks() {
  print(msg('sortChoice'));
  int? choice = readInt('');
  if (choice == 1) {
    library.sort((a, b) => a.title.compareTo(b.title));
  } else if (choice == 2) {
    library.sort((a, b) => a.year.compareTo(b.year));
  }
  listBooks();
}

// Language toggle
void switchLanguage() {
  lang = (lang == 'en') ? 'ar' : 'en';
  print(msg('languageSwitched'));
}

// Main loop
void main() {
  loadBooks();
  while (true) {
    print(msg('menu'));
    int? choice = readInt('');
    switch (choice) {
      case 1:
        listBooks();
        break;
      case 2:
        addBook();
        break;
      case 3:
        editBook();
        break;
      case 4:
        searchBooks();
        break;
      case 5:
        deleteBook();
        break;
      case 6:
        saveBooks();
        break;
      case 7:
        loadBooks();
        break;
      case 8:
        sortBooks();
        break;
      case 9:
        switchLanguage();
        break;
      case 10:
        print(msg('goodbye'));
        return;
      default:
        print(msg('invalid'));
    }
  }
}
