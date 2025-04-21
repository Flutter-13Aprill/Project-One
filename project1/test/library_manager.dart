import 'book.dart';
import 'storage.dart';

class LibraryManager {
  List<Book> books = [];
  int nextId = 1;

  Future<void> initialize() async {
    books = await Storage.loadBooks();
    if (books.isNotEmpty) {
      nextId = books.map((b) => b.id).reduce((a, b) => a > b ? a : b) + 1;
    }
  }

  Future<void> addBook(String title, String author, int year, String genre) async {
    if (books.any((b) => b.title == title && b.author == author)) return;
    books.add(Book(nextId++, title, author, year, genre));
    await Storage.saveBooks(books);
  }

  Future<void> deleteBook(int id) async {
    books.removeWhere((b) => b.id == id);
    await Storage.saveBooks(books);
  }

  Future<void> editBook(int id, {String? title, String? author, int? year, String? genre}) async {
    final book = books.firstWhere((b) => b.id == id, orElse: () => Book(-1, '', '', 0, ''));
    if (book.id == -1) return;
    if (title != null && title.isNotEmpty) book.title = title;
    if (author != null && author.isNotEmpty) book.author = author;
    if (year != null) book.year = year;
    if (genre != null && genre.isNotEmpty) book.genre = genre;
    await Storage.saveBooks(books);
  }

  List<Book> search(String keyword) {
    return books.where((b) =>
      b.title.toLowerCase().contains(keyword.toLowerCase()) ||
      b.author.toLowerCase().contains(keyword.toLowerCase())).toList();
  }

  Future<void> sortByTitle() async {
    books.sort((a, b) => a.title.compareTo(b.title));
    await Storage.saveBooks(books);
  }

  Future<void> sortByYear() async {
    books.sort((a, b) => a.year.compareTo(b.year));
    await Storage.saveBooks(books);
  }
}
