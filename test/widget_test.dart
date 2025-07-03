import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pockettasks/main.dart';
import 'package:pockettasks/model/task.dart';
import 'package:pockettasks/page.dart/task_list.dart';
import 'package:pockettasks/widgets/task_tile.dart';


void main() {
  testWidgets('TaskListScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byWidget(TaskListScreen()), findsOneWidget);
  });

  testWidgets('Add Task floating action button', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('displays task title', (WidgetTester tester) async {
    final task = Task(id: '1', title: 'Test Task');
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TaskTile(
          task: task,
          onToggle: () {},
          onDelete: () {},
          onTap: () {},
        ),
      ),
    ));
    expect(find.text('Test Task'), findsOneWidget);
  });

  testWidgets('Completed task shows line-through', (WidgetTester tester) async {
    final task = Task(id: '1', title: 'Completed Task', completed: true);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TaskTile(
          task: task,
          onToggle: () {},
          onDelete: () {},
          onTap: () {},
        ),
      ),
    ));

    final textWidget = tester.widget<Text>(find.text('Completed Task'));
    expect(textWidget.style?.decoration, TextDecoration.lineThrough);
  });
}