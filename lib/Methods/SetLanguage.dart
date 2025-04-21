

//function  allow user to chosse arabic or english
import 'dart:io';

import 'package:book/Methods/GetLocalizedMessage.dart';
import 'package:book/book.dart';

void setLanguage() {
  //promt appers to allow user to change language
  stdout.write(
    getLocalizedMessage(
      "Choose 1 for English, 2 for Arabic: ",
      "  اضغط 1 للغه الانجليزيه ,اضغط 2 للغه العربية",
    ),
  );
  //choice is ether 1or 2
  int choice = int.parse(stdin.readLineSync()!);
  //if choice=1 means chosse english other arabic
  isEnglish = choice == 1;
}