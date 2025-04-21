import 'package:book/Methods/Book.dart';
import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/book.dart';

Future<void> displayBooks() async {
  if (books.isNotEmpty) {
    // Map to store books categorized by their categories
    Map<String, List<Book>> categorizedBooks = {};

    for (var element in books) {
      // Check if the category exists in the map; if not, add it
      if (!categorizedBooks.containsKey(element.categories)) {
        categorizedBooks[element.categories] = [];
      }
      // Add the book to the appropriate category
      categorizedBooks[element.categories]!.add(element);
    }

    // Print books by categories
    categorizedBooks.forEach((category, books) {
      print('Category: $category');
      for (var book in books) {
        print(book.toString());
      }
    });
    print("\n");
  } else {
    print(
      getLocalizedMessage(
        "The library does not have any book.",
        "لا يوجد أي كتاب بالمكتبة",
      ),
    );
  }
}
