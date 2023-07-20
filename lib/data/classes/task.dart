import 'package:flutter_project_task_reminder/data/classes/task_type.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task({
    required this.title,
    this.comment = '',
    this.isDone = false,
    required this.time,
    required this.taskType,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String comment;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  DateTime time;

  @HiveField(4)
  TaskType taskType;
}
