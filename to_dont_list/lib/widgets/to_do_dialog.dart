import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/dog.dart';

typedef ToDoListAddedCallback = Function(
    String value,
    CollarColor collarColor,
    String breed,
    String size,
    Color coatColor,
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
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);

  String valueText = "";
  String breedText = "";
  Color coatColor = Colors.brown; // Default coat color
  CollarColor collarColor = CollarColor.collar;

  String sizeText = "Small";
  List<String> sizes = ["Small", "Medium", "Large"];

  // Define coat color stops for the gradient
  final List<Color> coatColors = [
    Colors.grey.shade800,  
    Colors.brown.shade600,   
    Colors.black,        
    Colors.white, 
    Colors.brown.shade300,
    Colors.grey.shade400, 
  ];

  Widget _buildCoatColorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Coat Color:"),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector( // This allows user to pick color
            onPanUpdate: (details) {
              final RenderBox box = context.findRenderObject() as RenderBox; // renders the colors as a box
              final localPosition = details.localPosition;
              final dx = localPosition.dx.clamp(0, box.size.width);
            
              final position = dx / box.size.width;
            
              final color = _getColorAtPosition(position); // you pick a color when sliding across the gradiant
              
              setState(() {
                coatColor = color;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                gradient: LinearGradient( // This allows for that gradiant
                  colors: coatColors,
                  stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0], // where the colors in that gradiant stop and start
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 30,
          width: 60,
          decoration: BoxDecoration( // shows what color your picking
            color: coatColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4), // rounds box corners
          ),
        ),
      ],
    );
  }

  Color _getColorAtPosition(double position) {
    // Find the segment that contains our position
    final segmentWidth = 1.0 / (coatColors.length - 1);
    final index = (position / segmentWidth).floor();
    final remainder = (position - (index * segmentWidth)) / segmentWidth;
    
    if (index >= coatColors.length - 1) return coatColors.last;
    
    // Interpolate between the two colors
    return Color.lerp(
      coatColors[index],
      coatColors[index + 1],
      remainder,
    ) ?? coatColors[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: 16),
            _buildCoatColorPicker(),
            const SizedBox(height: 16),
            const Align(alignment: Alignment.centerLeft, child: Text("Dog Size:")),
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
                  child: Text(size),
                );
              }).toList(),
            ),
            const Align(alignment: Alignment.centerLeft, child: Text("Collar Color:")),
            DropdownButton<CollarColor>(
              value: collarColor,
              onChanged: (CollarColor? newValue) {
                setState(() {
                  collarColor = newValue!;
                });
              },
              items: CollarColor.values.map((CollarColor classType) {
                return DropdownMenuItem<CollarColor>(
                  value: classType,
                  child: Text(classType.name),
                );
              }).toList(),
            ),
          ],
        ),
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
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty && breedText.isNotEmpty && sizeText.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(
                          value.text,
                          collarColor,
                          breedText,
                          sizeText,
                          coatColor,
                          _inputController,
                        );
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
