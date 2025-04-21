import 'package:uuid/uuid.dart';

class Book{

  Book({required String? title, required String? author, required String? genre, required int? publicationYear}){
    _title = title;
    _author = author;
    _genre = genre;
    _publicationYear = publicationYear;
  }

   Book.fromJson(dynamic json){
    _title = json['title'] as String?;
    _author = json['author'] as String?;
    _genre = json['genre'] as String?;
    _publicationYear = json['publication_year'] as int?;
   }

  // ignore: unused_field
  final _id = Uuid().v4();
  String? _title;
  String? _author;
  String? _genre;
  int? _publicationYear;

  // Getters
  String? get getTitle => _title;
  String? get getAuthor => _author;
  String? get getGenre => _genre;
  int? get getPublicationYear => _publicationYear;

  // Setters
  set setTitle(String? title){
    _title = title;
  }

  set setAuthor(String? author){
    _author = author;
  }

  set setGenre(String? genre){
    _genre = genre;
  }

  set setPublicationYear(int? publicationYear){
    _publicationYear = publicationYear;
  }

  // To convert Book's properties into map that we could store it in a JSON format
  Map<String, dynamic> toJson(){
    return{
      'title': getTitle,
      'author': getAuthor,
      'genre': getGenre,
      'publication_year': getPublicationYear
    };
  }


}