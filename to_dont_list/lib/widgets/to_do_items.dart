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
    return ListTile(
      onTap: () {
        widget.onListChanged(widget.dog, widget.completed);
      },
      onLongPress: widget.completed
          ? () {
              widget.onDeleteItem(widget.dog);
            }
          : null,
      //circle avatar can be replaced by button or icon, if onPressed is used for button call setState() (must be stateful widget)
      leading: ElevatedButton(
        onPressed: () {
          setState(() {
            widget.dog.encounter();
          });
        },
        style:
            ElevatedButton.styleFrom(backgroundColor: widget.dog.collar.color),
        child: Text(widget.dog.count.toString()),
      ),
      title: Row(
        children: [
          Text(
            "Name: ${widget.dog.name},",
            style: _getTextStyle(context),
          ),
          const SizedBox(width: 10),
          Text(
            "Breed: ${widget.dog.breed},",
            style: _getTextStyle(context),
          ),
          const SizedBox(width: 10),
          Text(
            "Size: ${widget.dog.size},",
            style: _getTextStyle(context),
          ),
          const SizedBox(width: 10),
          Text(
            "COAT",
            style: TextStyle(
              color: widget.dog.coat,
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              shadows: const [
                // Add outline effect using shadows, make it readable
                Shadow(
                  offset: Offset(-1, -1),
                  color: Colors.black,
                  blurRadius: 1,
                ),
                Shadow(
                  offset: Offset(1, -1),
                  color: Colors.black,
                  blurRadius: 1,
                ),
                Shadow(
                  offset: Offset(-1, 1),
                  color: Colors.black,
                  blurRadius: 1,
                ),
                Shadow(
                  offset: Offset(1, 1),
                  color: Colors.black,
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
