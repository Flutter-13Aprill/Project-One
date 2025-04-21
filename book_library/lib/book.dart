class Book {
  int? _id;
  String? _bookTitle;
  String? _authorName;
  int? _publicationYear;

  Book(this._bookTitle, this._authorName, this._publicationYear);


  set bookId(int newId) => _id = newId;
  int get bookId => _id!;

  //Convert to JSON (json Encode)
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'bookTitle': _bookTitle, //'key' : value
      'authorName': _authorName,
      'publicationYear': _publicationYear,
    };
  }

  // Convert from JSON (json Decode)
  factory Book.fromJson(Map<String, dynamic> json) {
    Book book = Book(
      json['bookTitle'],
      json['authorName'],
      json['publicationYear'],
    );
    book._id = json['id'];
    return book;
  }
}
