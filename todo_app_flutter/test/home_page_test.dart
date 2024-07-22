import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo/pages/home_page.dart';

void main() {
  group('HomePage Tests', () {
    testWidgets('Add new task', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: HomePage()));

      // Verify that initially there are no tasks.
      expect(find.text('Drink Coffee'), findsNothing);

      // Enter a new task and add it.
      await tester.enterText(find.byType(TextField), 'Drink Coffee');
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that the new task appears in the list.
      expect(find.text('Drink Coffee'), findsOneWidget);
    });

    testWidgets('Delete task', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: HomePage()));

      // Add a task to delete.
      await tester.enterText(find.byType(TextField), 'Drink Coffee');
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that the task is added.
      expect(find.text('Drink Coffee'), findsOneWidget);

      // Swipe to delete the task.
      await tester.drag(find.text('Drink Coffee'), Offset(-500, 0));
      await tester.pump();

      // Verify that the task is removed.
      expect(find.text('Drink Coffee'), findsNothing);
    });
  });
}
