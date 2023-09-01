import 'package:hive/hive.dart';

part 'task_type_enum.g.dart';

@HiveType(typeId: 3)
enum TaskTypeEnum {
  @HiveField(0)
  workout,

  @HiveField(1)
  work,

  @HiveField(2)
  payments,

  @HiveField(3)
  meeting,

  @HiveField(4)
  relax,
}
