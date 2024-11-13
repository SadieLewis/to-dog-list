// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/dog.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  //new/modified test
  testWidgets('DogListItem has collar color as elevated button',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: DogListItem(
                dog: Dog(
                    name: "test", collar: CollarColor.blue, breed: "testbreed", size: "small", coat: Colors.black),
                completed: true,
                onListChanged: (Dog dog, bool completed) {},
                onDeleteItem: (Dog dog) {}))));
    final buttonFinder = find.byType(ElevatedButton);
    final ElevatedButton test = tester.widget(buttonFinder);
    final buttonColor = test.style?.backgroundColor?.resolve({});

    expect(buttonColor, equals(CollarColor.blue.color));
  });

  testWidgets('DogListItem contains texts', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: DogListItem(
                dog: Dog(
                    name: "test", collar: CollarColor.blue, breed: "testbreed", size: "small", coat: Colors.black),
                completed: true,
                onListChanged: (Dog dog, bool completed) {},
                onDeleteItem: (Dog dog) {}))));

    final nameFinder = find.text("Name: test,");
    final breedFinder = find.text("Breed: testbreed");

    expect(nameFinder, findsOneWidget);
    expect(breedFinder, findsOneWidget);
  });

  // new/modified test
  testWidgets('DogListItem has Elevated Button that increments',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DogListItem(
              dog: Dog(name: "test", collar: CollarColor.blue, breed: "test", size: "small", coat: Colors.black),
              completed: true,
              onListChanged: (Dog dog, bool completed) {},
              onDeleteItem: (Dog dog) {}),
        ),
      ),
    );
    final buttonFinder = find.byType(ElevatedButton);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text('2'), findsOne);
  });

  testWidgets('Default ToDogList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDogList()));

    final listItemFinder = find.byType(DogListItem);

    expect(listItemFinder, findsOneWidget);
  });

  testWidgets('Clicking and Typing adds to ToDogList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDogList()));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Rebuild the widgets to show the dialog.

    expect(find.text("Dog name:"), findsOneWidget);
    expect(find.text("Dog breed:"), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'name');
    await tester.pump();
    expect(find.text("name"), findsOneWidget);

    await tester.enterText(find.byType(TextField).last, 'breed');
    await tester.pump();

    expect(find.text("breed"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();

    expect(find.text("Name: name,"), findsOneWidget);
    expect(find.text("Breed: breed"), findsOneWidget);

    final listItemFinder = find.byType(DogListItem);
    expect(listItemFinder, findsNWidgets(2));
  });

  // One to test the tap and press actions on the items?
}
