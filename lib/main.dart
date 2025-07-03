import 'package:flutter/material.dart';
import 'package:pockettasks/model/task.dart';
import 'package:pockettasks/page.dart/task_list.dart';
import 'package:pockettasks/state_mgt/tasks_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Tasks',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const TaskListScreen(),
    );
  }
}