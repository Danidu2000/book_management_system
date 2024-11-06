import '../models/book.dart';

class BookService {
  List<Book> books = [];

  // Add a new book to the collection
  void addBook(Book book) {
    books.add(book);
  }

  // Remove a book from the collection
  void removeBook(String isbn) {
    books.removeWhere((book) => book.isbn == isbn);
  }

  // Update the status of a book
  void updateStatus(String isbn, BookStatus status) {
    final book = books.firstWhere((book) => book.isbn == isbn);
    book.updateStatus(status);
  }

  // Search for books by title or author
  List<Book> searchBooks(String query) {
    return books.where((book) {
      return book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.author.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Filter books by availability status
  List<Book> filterBooks(BookStatus status) {
    return books.where((book) => book.status == status).toList();
  }

  // Get all books
  List<Book> getAllBooks() {
    return books;
  }
}
