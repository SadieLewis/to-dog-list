import 'package:flutter/material.dart';

enum CollarColor {
  red(Color.fromARGB(255, 222, 78, 68)),
  orange(Color.fromARGB(255, 247, 155, 17)),
  yellow(Color.fromARGB(255, 255, 235, 59)),
  green(Color.fromARGB(255, 15, 128, 19)),
  blue(Color.fromARGB(255, 38, 114, 177)),
  purple(Color.fromARGB(255, 200, 92, 219)),
  pink(Color.fromARGB(255, 240, 104, 149)),
  collar(Color.fromARGB(255, 255, 255, 255));

  const CollarColor(this.color);
  final Color color;
}

class Dog {
  Dog({required this.name, required this.collar, required this.breed, required this.size, required this.coat});

  final String name;
  final String breed;
  final CollarColor collar;
  final String size;
  final Color coat;
  int count = 1;
  //not needed?
  void encounter() {
    count++;
  }
}
