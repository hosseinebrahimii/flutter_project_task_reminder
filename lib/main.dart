import 'package:flutter/material.dart';
import 'package:flutter_project_task_reminder/data/classes/task.dart';
import 'package:flutter_project_task_reminder/data/classes/task_type.dart';
import 'package:flutter_project_task_reminder/data/classes/task_type_enum.dart';
import 'package:flutter_project_task_reminder/pages/1.tasks_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());

  await Hive.openBox<Task>('TaskBox');

  runApp(const ReminderApp());
}

class ReminderApp extends StatelessWidget {
  const ReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TasksPage(),
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'SM',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontFamily: 'SM',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
