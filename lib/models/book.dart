enum BookStatus { available, borrowed }

class Book {
  String title;
  String author;
  String isbn;
  BookStatus status;

  // Constructor
  Book({
    required this.title,
    required this.author,
    required this.isbn,
    this.status = BookStatus.available,
  });

  // ISBN Validation
  bool isValidISBN() {
    // Assuming a simple ISBN validation: 13 characters long
    return isbn.length == 13;
  }

  // Method to update the status
  void updateStatus(BookStatus newStatus) {
    status = newStatus;
  }
}