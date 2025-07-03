import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pockettasks/model/task.dart';


class TasksProvider with ChangeNotifier {
  final Box<Task> _tasksBox = Hive.box<Task>('tasks');

  List<Task> get allTasks => _tasksBox.values.toList();
  
  List<Task> get activeTasks => _tasksBox.values.where((task) => !task.completed).toList();
  
  List<Task> get completedTasks => _tasksBox.values.where((task) => task.completed).toList();

  void addTask(Task task) {
    _tasksBox.put(task.id, task);
    notifyListeners();
  }

  void updateTask(Task task) {
    _tasksBox.put(task.id, task);
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasksBox.delete(id);
    notifyListeners();
  }

  void toggleTaskCompletion(String id) {
    final task = _tasksBox.get(id);
    if (task != null) {
      task.completed = !task.completed;
      _tasksBox.put(id, task);
      notifyListeners();
    }
  }
}