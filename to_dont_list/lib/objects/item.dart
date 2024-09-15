// Data class to keep the string and have an abbreviation function

class Item {
  const Item({required this.name, required this.name2});

  final String name;
  final String name2;

  String abbrev() {
    return name.substring(0, 1);
  }
}
