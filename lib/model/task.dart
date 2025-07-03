import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  String title;
  
  @HiveField(2)
  String? note;
  
  @HiveField(3)
  DateTime? dueDate;
  
  @HiveField(4)
  bool completed;
  
  @HiveField(5)
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.note,
    this.dueDate,
    this.completed = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

