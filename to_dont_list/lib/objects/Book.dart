// Data class to keep the string and have an abbreviation function

class Book {
  const Book({required this.title, required this.author, required this.pages, required this.curPage});

  final String title;
  final String author;
  final String pages;
  final String curPage;

  String abbrev() {
    return title.substring(0, 1);
  }
}
