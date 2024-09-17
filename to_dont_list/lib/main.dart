// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/Book.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Book> books = [const Book(title: "Book", author: "Author", pages: "100", curPage: "1")];
  final _bookset = <Book>{};

  void _handleListChanged(Book book, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _bookset inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      books.remove(book);
      if (!completed) {
        print("Completing");
        _bookset.add(book);
        books.add(book);
      } else {
        print("Making Undone");
        _bookset.remove(book);
        books.insert(0, book);
      }
    });
  }

  void _handleDeleteItem(Book item) {
    setState(() {
      print("Deleting item");
      books.remove(item);
    });
  }

  void _handleNewItem(String itemText, String itemText2, String itemText3, String itemText4, TextEditingController textController, TextEditingController textController2, TextEditingController textController3, TextEditingController textController4) {
    setState(() {
      print("Adding new item");
      Book book = Book(title: itemText, author: itemText2, curPage: itemText3, pages: itemText4);
      books.insert(0, book);
      textController.clear();
      textController2.clear();
      textController3.clear();
      textController4.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: books.map((book) {
            return ToDoListItem(
              book: book,
              completed: _bookset.contains(book),
              onListChanged: _handleListChanged,
              onDeleteItem: _handleDeleteItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: _handleNewItem);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'To Do List',
    home: ToDoList(),
  ));
}
