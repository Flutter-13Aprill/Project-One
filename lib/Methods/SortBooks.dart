
// Function to sort books by their titles
import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/book.dart';

void sortBooks() async{
  // If there are no books, do nothing
  if (books.isEmpty) {
    return;
  }
  // Sort the books list based on the title of each book
  books.sort((a, b) => a.title.compareTo(b.title));
  // Print a message indicating that the books have been sorted
  print(
    getLocalizedMessage(
      "Books sorted by title.",
      "تم ترتيب الكتب حسب العنوان.",
    ),
  );
}