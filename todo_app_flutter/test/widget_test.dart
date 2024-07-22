import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_calendar/table_calendar.dart'; // Tambahkan ini
import 'package:simple_todo/pages/home_page.dart';

void main() {
  testWidgets('Calendar widget should be present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Verify if the calendar widget is present
    expect(find.byType(TableCalendar), findsOneWidget);
  });

  testWidgets('Add new task and verify', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    expect(find.text('Drink Coffee'), findsNothing);

    await tester.enterText(find.byType(TextField), 'Drink Coffee');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Drink Coffee'), findsOneWidget);
  });

  testWidgets('Delete task and verify', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    await tester.enterText(find.byType(TextField), 'Drink Coffee');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Drink Coffee'), findsOneWidget);

    await tester.drag(find.text('Drink Coffee'), Offset(-500, 0));
    await tester.pump();

    expect(find.text('Drink Coffee'), findsNothing);
  });
}
