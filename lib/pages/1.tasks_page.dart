import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project_task_reminder/data/classes/task.dart';
import 'package:flutter_project_task_reminder/data/models/show_task_widget.dart';
import 'package:flutter_project_task_reminder/pages/2.set_task_page.dart';

import 'package:hive_flutter/hive_flutter.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

var taskBox = Hive.box<Task>('TaskBox');
bool isVisible = true;

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(),
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: taskBox.listenable(),
          builder: (BuildContext context, dynamic value, Widget? child) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                setState(() {
                  if (notification.direction == ScrollDirection.reverse && taskBox.values.length > 5) {
                    isVisible = false;
                  } else if (notification.direction == ScrollDirection.forward) {
                    isVisible = true;
                  }
                });
                return true;
              },
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  Task task = taskBox.values.toList()[index];
                  return _getListItem(task);
                }),
                itemCount: taskBox.values.length,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getFloatingActionButton() {
    return Visibility(
      visible: isVisible,
      child: FloatingActionButton(
        backgroundColor: const Color(0xff18DAA3),
        onPressed: () {
          focusGuard1 = FocusNode();
          focusGuard2 = FocusNode();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) {
                return const SetTaskPage();
              }),
            ),
          );
        },
        child: Image.asset('images/icon_add.png'),
      ),
    );
  }

  Widget _getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => task.delete(),
      child: ShowTaskWidget(task: task),
    );
  }
}