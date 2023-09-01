import 'package:flutter_project_task_reminder/models/task_type.dart';
import 'package:flutter_project_task_reminder/models/task_type_enum.dart';

List<TaskType> taskTypeList = [
  TaskType(
    imageAddress: 'images/workout.png',
    name: 'ورزش',
    type: TaskTypeEnum.workout,
  ),
  TaskType(
    imageAddress: 'images/meditate.png',
    name: 'استراحت',
    type: TaskTypeEnum.relax,
  ),
  TaskType(
    imageAddress: 'images/payments.png',
    name: 'حسابرسی',
    type: TaskTypeEnum.payments,
  ),
  TaskType(
    imageAddress: 'images/working.png',
    name: 'کار',
    type: TaskTypeEnum.work,
  ),
  TaskType(
    imageAddress: 'images/meeting.png',
    name: 'جلسه',
    type: TaskTypeEnum.meeting,
  ),
];
