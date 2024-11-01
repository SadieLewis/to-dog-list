import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/dog.dart';

typedef ToDoListAddedCallback = Function(
    //add color
    String value,
    CollarColor collarColor,
    String breed,
    String size,
    String coat,
    TextEditingController textController);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _coatController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  String breedText = "";
  String coatText = "";
  CollarColor collarColor = CollarColor.collar;

  String sizeText = "Small";
  List<String> sizes = ["Small", "Medium", "Large"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      //make column to add more stuff, so after textfield another button/icon/whatever can be placed (drop down collar color option?)
      content: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _inputController,
            decoration: const InputDecoration(hintText: "Dog name:"),
          ),
          TextField(
            onChanged: (breed) {
              setState(() {
                breedText = breed;
              });
            },
            controller: _breedController,
            decoration: const InputDecoration(hintText: "Dog breed:"),
          ),
          TextField(
            onChanged: (coat) {
              setState(() {
                coatText = coat;
              });
            },
            controller: _coatController,
            decoration: const InputDecoration(hintText: "Dog coat:"),
          ),
          const Align( alignment: Alignment.centerLeft ,child: Text("Dog Size:")),
          DropdownButton<String>(
                value: sizeText,
                hint: const Text("Select size:"),
                onChanged: (newValue) {
                    setState(() {
                      sizeText = newValue!;
                    });
                },
                items: sizes.map((String size) {
                    return DropdownMenuItem<String>(
                        value: size, 
                        child: Text(size)
                    );
                }).toList()
            ),
          
          /* TextField(
            onChanged: (size) {
              setState(() {
                sizeText = size;
              });
            },
            controller: _sizeController,
            decoration: const InputDecoration(hintText: "Dog size:"),
          ),
          */
          const Align( alignment: Alignment.centerLeft ,child: Text("Collar Color:")),
          DropdownButton<CollarColor>(
              value: collarColor,
              onChanged: (CollarColor? newValue) {
                setState(() {
                  collarColor = newValue!;
                });
              },
              items: CollarColor.values.map((CollarColor classType) {
                return DropdownMenuItem<CollarColor>(
                    value: classType, child: Text(classType.name));
              }).toList())
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty && breedText.isNotEmpty && sizeText.isNotEmpty && coatText.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(value.text, collarColor, breedText, sizeText, coatText,
                            _inputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}
