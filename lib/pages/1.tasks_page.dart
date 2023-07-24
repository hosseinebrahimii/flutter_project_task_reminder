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
bool isTaskListVisible = true;

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButtons(),
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: taskBox.listenable(),
          builder: (BuildContext context, dynamic value, Widget? child) {
            if (taskBox.isEmpty) {
              return const Center(
                child: Text(
                  'تسکی ثبت نشده است',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SM',
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  setState(
                    () {
                      if (notification.direction == ScrollDirection.reverse && taskBox.values.length > 5) {
                        isTaskListVisible = false;
                      } else if (notification.direction == ScrollDirection.forward) {
                        isTaskListVisible = true;
                      }
                    },
                  );
                  return true;
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Task task = taskBox.values.toList()[index];
                    return _getListItem(task);
                  },
                  itemCount: taskBox.values.length,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _getFloatingActionButtons() {
    return Visibility(
      visible: isTaskListVisible,
      child: Row(
        children: [
          const SizedBox(
            width: 35,
          ),
          ValueListenableBuilder(
            valueListenable: taskRemovingListNotifier,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return Visibility(
                visible: taskRemovingListNotifier.value.isNotEmpty,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  heroTag: 'delete',
                  onPressed: () {
                    setState(
                      () {
                        for (var task in taskBox.values) {
                          if (taskRemovingListNotifier.value.contains(task)) {
                            task.delete();
                            taskRemovingListNotifier.value =
                                taskBox.values.where((element) => element.isDone == true).toList();
                          }
                        }
                      },
                    );
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.delete_outline,
                        size: 30,
                      ),
                      Positioned(
                        top: -15,
                        right: -15,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          radius: 9,
                          child: Text(
                            taskRemovingListNotifier.value.length.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          FloatingActionButton(
            backgroundColor: const Color(0xff18DAA3),
            onPressed: () {
              focusGuard1 = FocusNode();
              focusGuard2 = FocusNode();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SetTaskPage();
                  },
                ),
              );
            },
            child: Image.asset('images/icon_add.png'),
          ),
        ],
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
