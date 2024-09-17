
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/Book.dart';

typedef ToDoListChangedCallback = Function(Book book, bool completed);
typedef ToDoListRemovedCallback = Function(Book book);

class ToDoListItem extends StatelessWidget {
  ToDoListItem(
      {required this.book,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(book));

  final Book book;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed //
        ? const Color(0x8a000000)
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Color(0x88000000),
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(book, completed);
      },
      onLongPress: completed
          ? () {
              onDeleteItem(book);
            }
          : null,
      leading: ClipRRect(
        child: Container(
          height: 70.0,
          width: 40.0,
          color: _getColor(context),
          child: Text(book.abbrev(), textAlign: TextAlign.center, textScaler: const TextScaler.linear(3.0) ,),
        )
      ),
      title: Text(
        book.title,
        style: _getTextStyle(context),
      ),
      subtitle: Text(
        book.author,
        style: _getTextStyle(context),
      )
    );
  }
}
