import 'dart:io' as io;

import 'package:book_library/file_operation.dart';
import "package:translator_plus/translator_plus.dart";

class TranslationService with FileOperation {
  String currentLanguage = 'en';
  String fileName = "arabic_translation.json";

  final translator = GoogleTranslator();

  Map<String, String> cachedTranslations ={} ;

  // Future<void> loadTranslations() async {
  //   // final Map<String, dynamic> file = await jsonReader(fileName);
  //   // cachedTranslations = Map<String, String>.from(data);
  //   await jsonWriter(fileName, cachedTranslations);
  // }

  //* display a list for user to choose Language
  Future<int> chooseLanguage() async {
    int? selectedLanguage;

    print("\n******** Welcome to My Book Library ********\n");
    print("Choose your preferred language 🌐:\n");
    print("1- ﺔﻴﺑﺮﻌﻟﺍ.\n2- English.\n3- Exit");
    do {
      io.stdout.write('\nEnter Your Choice: ');
      selectedLanguage = int.parse(io.stdin.readLineSync()!);

      switch (selectedLanguage) {
        case 1:
          currentLanguage = 'ar';
          print("\n(.ﺔﻴﺑﺮﻌﻟﺍ ﺔﻐﻠﻟﺍ ﺭﺎﻴﺘﺧﺍ ﻢﺗ)\n");
          break;

        case 2:
          currentLanguage = 'en';
          print("\n(English selected.)\n");
          break;

        case 3:
          io.exit(0);

        default:
          print("Invalid choice. Please choose from 1 to 3.");
      }
    } while (selectedLanguage < 1 || selectedLanguage > 3);
    return selectedLanguage;
  }

  //*Transl the  system to Ar or En
  Future<String> translate(String text) async {
    if (currentLanguage == 'en') return text;
    var translation = await translator.translate(
      text,
      from: 'en',
      to: currentLanguage,
    );

    final reversedText = translation.text.split('').reversed.join();
    return '\u200F $reversedText';
  }
}
