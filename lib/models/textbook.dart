import 'book.dart';

class TextBook extends Book {
  String subjectArea;
  String gradeLevel;

  // Constructor with super call
  TextBook({
    required String title,
    required String author,
    required String isbn,
    BookStatus status = BookStatus.available,
    required this.subjectArea,
    required this.gradeLevel,
  }) : super(
    title: title,
    author: author,
    isbn: isbn,
    status: status,
  );
}