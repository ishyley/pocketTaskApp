import 'package:flutter/material.dart';
import 'package:pockettasks/model/task.dart';


class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const TaskTile({
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      background: Container(color: Colors.red),
      onDismissed: (_) => onDelete(),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: task.completed,
            onChanged: (_) => onToggle(),
          ),
          title: Text(
            task.title,
            style: task.completed
                ? TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
          subtitle: task.note != null ? Text(task.note!) : null,
          trailing: task.dueDate != null
              ? Text(
                  'Due: ${task.dueDate!.toLocal().toString().split(' ')[0]}')
              : null,
          onTap: onTap,
        ),
      ),
    );
  }
}