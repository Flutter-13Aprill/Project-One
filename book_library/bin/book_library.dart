import 'package:book_library/book_manager.dart';
import 'package:book_library/translation_service.dart';

void main() async {
  TranslationService translate = TranslationService();
  await translate.chooseLanguage();

  BookManager bookMang = BookManager(translator: translate);
   bookMang.startBookOperations();
}
