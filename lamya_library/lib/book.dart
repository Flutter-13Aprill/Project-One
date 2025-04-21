//Represents a single book with its ID, title, author, year, and categories
class Book {
  //Declaration
  int bookId = 1;
  String title;
  String author;
  int year;
  String categories;
  //Constructor
  Book(this.bookId, this.title, this.author, this.year, this.categories);
  // toString() to make book readable
  @override
  String toString() {
    return '📕 ID: $bookId\n📖 Title: $title\n✍️  Author: $author\n📅 Publishd Year: $year\n📚 Book categories: $categories\n';
  }
}
