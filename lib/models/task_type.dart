import 'package:flutter_project_task_reminder/models/task_type_enum.dart';
import 'package:hive/hive.dart';
part 'task_type.g.dart';

@HiveType(typeId: 2)
class TaskType {
  TaskType({
    required this.imageAddress,
    required this.name,
    required this.type,
  });

  @HiveField(0)
  String imageAddress;

  @HiveField(1)
  String name;

  @HiveField(2)
  TaskTypeEnum type;
}
