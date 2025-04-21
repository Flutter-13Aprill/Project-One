class Localization {
  final bool isArabic;
  Localization(this.isArabic);

  String get menu => isArabic ? '📚 مكتبة الكتب - الخيارات:' : '📚 Book Library - Menu:';
  String get listBooks => isArabic ? '1. عرض الكتب' : '1. List Books';
  String get addBook => isArabic ? '2. إضافة كتاب' : '2. Add Book';
  String get editBook => isArabic ? '3. تعديل كتاب' : '3. Edit Book';
  String get searchBook => isArabic ? '4. بحث عن كتاب' : '4. Search Book';
  String get deleteBook => isArabic ? '5. حذف كتاب' : '5. Delete Book';
  String get sortBooks => isArabic ? '6. ترتيب الكتب' : '6. Sort Books';
  String get exit => isArabic ? '7. خروج' : '7. Exit';
  String get choose => isArabic ? 'اختر رقم العملية: ' : 'Enter your choice: ';
  String get notFound => isArabic ? '❌ لم يتم العثور على الكتاب.' : '❌ Book not found.';
  String get added => isArabic ? '✅ تم إضافة الكتاب.' : '✅ Book added.';
  String get deleted => isArabic ? '✅ تم حذف الكتاب.' : '✅ Book deleted.';
  String get goodbye => isArabic ? '👋 إلى اللقاء!' : '👋 Goodbye!';
  String get duplicate => isArabic ? '⚠️ هذا الكتاب موجود بالفعل.' : '⚠️ This book already exists.';
}
