import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ToDoListAddedCallback = Function(
    String value, String value2, String value3, String value4, TextEditingController textConroller, TextEditingController textcontroller2, TextEditingController tectcontroller3, TextEditingController textcontroller4,);

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
  final TextEditingController _inputController2 = TextEditingController();
  final TextEditingController _inputController3 = TextEditingController();
  final TextEditingController _inputController4 = TextEditingController();
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);

  String valueText = "";
  String valueText2 = "";
  String valueText3 = "";
  String valueText4 = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: Column(children: [TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _inputController,
        decoration: const InputDecoration(hintText: "Book Title"),
      ),
      TextField(
        onChanged: (value2) {
          setState(() {
            valueText2 = value2;
          });
        },
        controller: _inputController2,
        decoration: const InputDecoration(hintText: "Author"),
      ),
      TextField(
        onChanged: (value3) {
          setState(() {
            valueText3 = value3;
          });
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        controller: _inputController3,
        decoration: const InputDecoration(hintText: "Current Page"),
      ),
      TextField(
        onChanged: (value4) {
          setState(() {
            valueText4 = value4;
          });
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        controller: _inputController4,
        decoration: const InputDecoration(hintText: "Max Pages"),
      ),
      
      ]
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
              onPressed: value.text.isNotEmpty && valueText2.isNotEmpty && valueText3.isNotEmpty && valueText4.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(valueText, valueText2, valueText3, valueText4, _inputController, _inputController2, _inputController3, _inputController4);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('Ok'),
            );
          },
        ),
      ],
    );
  }
}
