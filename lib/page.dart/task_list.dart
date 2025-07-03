import 'package:flutter/material.dart';
import 'package:pockettasks/model/task.dart';
import 'package:pockettasks/page.dart/add_edit_task.dart';
import 'package:pockettasks/state_mgt/tasks_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/task_tile.dart';


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TaskFilter _filter = TaskFilter.all;
  TaskSort _sort = TaskSort.creationDate;

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    List<Task> tasks = _getFilteredTasks(tasksProvider);
    tasks = _sortTasks(tasks);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket Tasks'),
        actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (filter) => setState(() => _filter = filter),
            itemBuilder: (context) => [
              const PopupMenuItem(value: TaskFilter.all, child: Text('All Tasks')),
              const PopupMenuItem(value: TaskFilter.active, child: Text('Active')),
              const PopupMenuItem(value: TaskFilter.completed, child: Text('Completed')),
            ],
          ),
          PopupMenuButton<TaskSort>(
            onSelected: (sort) => setState(() => _sort = sort),
            itemBuilder: (context) => [
              const PopupMenuItem(value: TaskSort.creationDate, child: Text('Sort by Creation')),
              const PopupMenuItem(value: TaskSort.dueDate, child: Text('Sort by Due Date')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, index) => TaskTile(
          task: tasks[index],
          onToggle: () => tasksProvider.toggleTaskCompletion(tasks[index].id),
          onDelete: () => tasksProvider.deleteTask(tasks[index].id),
          onTap: () => _navigateToEditTask(context, tasks[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _navigateToAddTask(context),
      ),
    );
  }

  List<Task> _getFilteredTasks(TasksProvider provider) {
    switch (_filter) {
      case TaskFilter.active:
        return provider.activeTasks;
      case TaskFilter.completed:
        return provider.completedTasks;
      case TaskFilter.all:
      default:
        return provider.allTasks;
    }
  }

  List<Task> _sortTasks(List<Task> tasks) {
    if (_sort == TaskSort.dueDate) {
      tasks.sort((a, b) {
        if (a.dueDate == null && b.dueDate == null) return 0;
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });
    } else {
      tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
    return tasks;
  }

  void _navigateToAddTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const AddEditTaskScreen()),
    );
  }

  void _navigateToEditTask(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => AddEditTaskScreen(task: task)),
    );
  }
}

enum TaskFilter { all, active, completed }
enum TaskSort { creationDate, dueDate }