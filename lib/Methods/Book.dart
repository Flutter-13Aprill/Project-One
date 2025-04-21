// Book class to store book information in the library
class Book {
  late String _title; //Title of the book
  late String _auther; //the author of book
  late String _publicationYear; //Year of publication
  late String _categories; // Categories of the book
  int bookId; // Unique ID for the book

  // Constructor to initialize book values
  Book(
    this._title,
    this._auther,
    this._publicationYear,
    this._categories,
    this.bookId,
  );

  // Convert properties to JSON format
  Map<String, dynamic> toJson() {
    return {
      "bookId": bookId,
      "title": _title,
      "auther": auther,
      "publicationYear": publicationYear,
      "categories": categories,
    };
  }

  // Factory constructor to return an object from JSON data
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      json['title'],
      json['auther'],
      json['publicationYear'],
      json['categories'],
      json["bookId"],
    );
  }

  @override
  // function return the all book information
  String toString() {
    return "id : $bookId ,title: $_title ,auther: $_auther ,publication year: $_publicationYear  categories:$categories";
  }

  // Setters to allow users to change book values
  // Setter to update the value of title
  set title(String title) {
    this._title = title;
  }
  // Setter to update the value of auther
  set auther(String auther) {
    this._auther = auther;
  }
  // Setter to update the value of publicationYear
  set publicationYear(String publicationYear) {
    this._publicationYear = publicationYear;
  }
  // Setter to update the value of categories
  set categories(String categories) {
    this._categories = categories;
  }
// Getter method to access private title 
  String get title => _title;
  // Getter method to access private auther 
  String get auther => _auther;
  // Getter method to access private publicationYear 
  String get publicationYear => _publicationYear;
  // Getter method to access private categories 
  String get categories => _categories;
} //end of book class
