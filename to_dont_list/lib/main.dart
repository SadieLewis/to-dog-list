// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/dog.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDogList extends StatefulWidget {
  const ToDogList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDogList> {
  final List<Dog> items = [
    Dog(name: "Fido", collar: CollarColor.red, breed: "Beagle", size: "Small", coat: Colors.brown)
  ];
  final _itemSet = <Dog>{};

  void _handleListChanged(Dog item, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      items.remove(item);
      if (!completed) {
        print("Completing");
        _itemSet.add(item);
        items.add(item);
      } else {
        print("Making Undone");
        _itemSet.remove(item);
        items.insert(0, item);
      }
    });
  }

  void _handleDeleteItem(Dog item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
    });
  }

  void _handleNewItem(String itemText, CollarColor collarColor, String breed, String size, Color coat,
      TextEditingController textController) {
    setState(() {
      print("Adding new item");

      Dog item = Dog(name: itemText, collar: collarColor, breed: breed, size: size, coat: coat);
      items.insert(0, item);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Dog List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 206, 255),
        elevation: 4,
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, size: 80, color: const Color.fromARGB(255, 238, 175, 238).withOpacity(0.7)),
                  const SizedBox(height: 20),
                  Text(
                    'No dogs yet! Add some.',
                    style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 246, 193, 224).withOpacity(0.8)),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final dog = items[index];
                return DogListItem(
                  dog: dog,
                  completed: _itemSet.contains(dog),
                  onListChanged: _handleListChanged,
                  onDeleteItem: _handleDeleteItem,
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return ToDoDialog(onListAdded: _handleNewItem);
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 255, 206, 255),
        label: const Text(
          'Add Dog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'To Dog List',
    home: ToDogList(),
  ));
}

//todo list with dogs, tracking dogs seen on campus
//use dogs instead of items, convert to stateful widget, downdrop appears, color changes
//change items in to do items to dogs, change import to use dog instead of item
//get color from material.dart, make enum for collar color? (name(Colors.colorname) or Color.fromARGB)