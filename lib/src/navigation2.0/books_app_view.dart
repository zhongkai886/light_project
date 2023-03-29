import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_project/src/navigation2.0/bloc/book_bloc.dart';

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  List<Page> onGeneratePages(BookState state, List<Page> pages) {
    final selectedBook = state.selectedBook;
    return [
      BooksListPage.page(books: state.books),
      if (selectedBook != null) BookDetailsPage.page(book: selectedBook)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      home: FlowBuilder(
        state: context.watch<BookBloc>().state,
        onGeneratePages: onGeneratePages,
      ),
    );
  }
}

class BooksListPage extends StatelessWidget {
  const BooksListPage({super.key, required this.books});

  static Page page({required List<Book> books}) {
    return MaterialPage(
      child: BooksListPage(
        books: books,
      ),
    );
  }

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: ListView(
        children: [
          for (final book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () {
                context.read<BookBloc>().add(BookSelected(book: book));
              },
            ),
        ],
      ),
    );
  }
}

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({super.key, required this.book});

  static Page page({required Book book}) {
    return MaterialPage(
      child: BookDetailsPage(
        book: book,
      ),
    );
  }

  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        context.read<BookBloc>().add(BookDeselected());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
          ),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  book.author,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          )),
    );
  }
}
