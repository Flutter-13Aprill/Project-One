class Book {
  int id;
  String title;
  String author;
  int year;
  String genre;

  Book(this.id, this.title, this.author, this.year, this.genre);

  Book.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        year = json['year'],
        genre = json['genre'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'year': year,
        'genre': genre,
      };

  @override
  String toString() {
    return '[$id] "$title" by $author ($year) - $genre';
  }
}
