import 'dart:convert';
import 'dart:io' as io;

mixin FileOperation {
  
  //*This Method responsible for write book data to Json
  Future<void> jsonWriter(
    String fileName,
    List<Map<String, dynamic>> newBook,
  ) async {
    final file = io.File(fileName); //open file

    //convert Map data to string Json (List<Map> --> Json)
    final jsonText = jsonEncode(newBook);
    file.writeAsStringSync(jsonText); // write to file
  }

  //*This Method responsible for read book data from Json
  Future<List<Map<String, dynamic>>> jsonReader(String fileName) async {
    final file = io.File(fileName); //open file

    if (await file.exists()) {
      final jsonFile = file.readAsStringSync(); //read file
      if (jsonFile.isNotEmpty) {
        //convert string Json to List (Json --> List<Map>)
        final List<dynamic> jsonText = jsonDecode(jsonFile);
        // List -> Map -> List<map>>
        return jsonText.map((json) => json as Map<String, dynamic>).toList();
      } else {
        print("The $fileName is Empty.");
      }
    } else {
      print("The $fileName does not exist.");
    }
    return [];
  }
}
