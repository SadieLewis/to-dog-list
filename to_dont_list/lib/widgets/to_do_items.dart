import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/dog.dart';

typedef ToDoListChangedCallback = Function(Dog dog, bool completed);
typedef ToDoListRemovedCallback = Function(Dog dog);

class DogListItem extends StatefulWidget {
  DogListItem(
      {required this.dog,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(dog));

  final Dog dog;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  @override
  State<DogListItem> createState() => _DogListItemState();
}

class _DogListItemState extends State<DogListItem> {
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return widget.completed ? Colors.black54 : Theme.of(context).primaryColor;
  }

  
  TextStyle? _getTextStyle(BuildContext context) {
    if (!widget.completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
  

  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        onTap: () {
          widget.onListChanged(widget.dog, widget.completed);
        },
        onLongPress: widget.completed
            ? () {
                widget.onDeleteItem(widget.dog);
              }
            : null,
        leading: ElevatedButton(
          onPressed: () {
            setState(() {
              widget.dog.encounter();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.dog.collar.color,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          child: Text(
            widget.dog.count.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.dog.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _getColor(context),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Breed: ${widget.dog.breed}, Size: ${widget.dog.size}",
              style: _getTextStyle(context)?.copyWith(fontSize: 14) ??
                  const TextStyle(fontSize: 14),
            ),
          ],
        ),
        trailing: Text(
          "COAT",
          style: TextStyle(
            color: widget.dog.coat,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(offset: Offset(-1, -1), color: Colors.black, blurRadius: 1),
              Shadow(offset: Offset(1, -1), color: Colors.black, blurRadius: 1),
              Shadow(offset: Offset(-1, 1), color: Colors.black, blurRadius: 1),
              Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 1),
            ],
          ),
        ),
        subtitle: widget.completed
            ? const Text(
                "Tap to undo or hold to delete.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              )
            : null,
      ),
    );
  }
}