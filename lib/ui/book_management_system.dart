import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BookManagementSystem extends StatefulWidget {
  @override
  _BookManagementSystemState createState() => _BookManagementSystemState();
}

class _BookManagementSystemState extends State<BookManagementSystem> {
  final BookService bookService = BookService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool showAvailableOnly = false;
  List<Book> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = bookService.getAllBooks();
  }

  // Add book
  void addBook() {
    final book = Book(
      title: _titleController.text,
      author: _authorController.text,
      isbn: _isbnController.text,
    );
    setState(() {
      bookService.addBook(book);
      filteredBooks = bookService.getAllBooks();
      _titleController.clear();
      _authorController.clear();
      _isbnController.clear();
    });
  }

  // Remove book
  void removeBook(String isbn) {
    setState(() {
      bookService.removeBook(isbn);
      filteredBooks = bookService.getAllBooks();
    });
  }

  // Update book status
  void updateStatus(String isbn, BookStatus status) {
    setState(() {
      bookService.updateStatus(isbn, status);
      filteredBooks = bookService.getAllBooks();
    });
  }

  // Search books
  void searchBooks() {
    setState(() {
      filteredBooks = bookService.searchBooks(_searchController.text);
    });
  }

  // Filter books
  void filterBooks() {
    setState(() {
      filteredBooks = showAvailableOnly
          ? bookService.filterBooks(BookStatus.available)
          : bookService.getAllBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Book Management System')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add book form
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              TextField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
              ),
              ElevatedButton(
                onPressed: addBook,
                child: Text('Add Book'),
              ),
              SizedBox(height: 20),

              // Search functionality
              TextField(
                controller: _searchController,
                decoration: InputDecoration(labelText: 'Search by Title or Author'),
                onChanged: (_) => searchBooks(),
              ),
              SizedBox(height: 10),

              // Filter books by availability
              Row(
                children: [
                  Checkbox(
                    value: showAvailableOnly,
                    onChanged: (value) {
                      setState(() {
                        showAvailableOnly = value!;
                        filterBooks();
                      });
                    },
                  ),
                  Text('Show Available Books Only'),
                ],
              ),
              SizedBox(height: 10),

              // Display book list with status toggle and remove
              Expanded(
                child: ListView.builder(
                  itemCount: filteredBooks.length,
                  itemBuilder: (context, index) {
                    final book = filteredBooks[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text('Author: ${book.author}, ISBN: ${book.isbn}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              book.status == BookStatus.available
                                  ? Icons.check_circle
                                  : Icons.remove_circle,
                              color: book.status == BookStatus.available
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            onPressed: () => updateStatus(
                                book.isbn, book.status == BookStatus.available
                                ? BookStatus.borrowed
                                : BookStatus.available),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeBook(book.isbn),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
