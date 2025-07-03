import 'package:flutter/material.dart';
import 'package:pockettasks/model/task.dart';
import 'package:pockettasks/state_mgt/tasks_provider.dart';
import 'package:provider/provider.dart';


class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddEditTaskScreen({this.task, super.key});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String? _note;
  late DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _note = widget.task?.note;
    _dueDate = widget.task?.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value?.isEmpty ?? true ? 'Title is required' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _note,
                decoration: const InputDecoration(labelText: 'Note (optional)'),
                onSaved: (value) => _note = value?.isEmpty ?? true ? null : value,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(_dueDate == null ? 'No due date' : 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}'),
                  TextButton(
                    child: const Text('Pick Date'),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() => _dueDate = date);
                      }
                    },
                  ),
                  if (_dueDate != null)
                    TextButton(
                      child: const Text('Clear'),
                      onPressed: () => setState(() => _dueDate = null),
                    ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                child: Text(widget.task == null ? 'Add Task' : 'Update Task'),
                onPressed: _saveTask,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
      final task = widget.task ?? Task(id: DateTime.now().toString(), title: _title);
      
      task.title = _title;
      task.note = _note;
      task.dueDate = _dueDate;
      
      if (widget.task == null) {
        tasksProvider.addTask(task);
      } else {
        tasksProvider.updateTask(task);
      }
      
      Navigator.pop(context);
    }
  }
}