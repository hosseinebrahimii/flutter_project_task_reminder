import 'package:flutter/material.dart';
import 'package:flutter_project_task_reminder/data/classes/task.dart';
import 'package:flutter_project_task_reminder/data/classes/task_type.dart';
import 'package:flutter_project_task_reminder/data/models/task_type_list.dart';

import 'package:time_pickerr/time_pickerr.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SetTaskPage extends StatefulWidget {
  const SetTaskPage({super.key});

  @override
  State<SetTaskPage> createState() => _SetTaskWidgetState();
}

FocusNode focusGuard1 = FocusNode();
FocusNode focusGuard2 = FocusNode();
var _taskBox = Hive.box<Task>('TaskBox');
var _titleTextController = TextEditingController();
var _commentTextController = TextEditingController();
DateTime? _taskTime;
TaskType? _taskType;
String _errorLine = '';

class _SetTaskWidgetState extends State<SetTaskPage> {
  @override
  void initState() {
    super.initState();
    focusGuard1.addListener(() {
      setState(() {});
    });
    focusGuard2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 850,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                _gettitleField(),
                const SizedBox(
                  height: 30,
                ),
                _getcommentField(),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 40,
                ),
                _getTaskTypeList(),
                const Spacer(),
                Text(
                  _errorLine,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SM',
                  ),
                ),
                _getTaskTime(),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gettitleField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        focusNode: focusGuard1,
        controller: _titleTextController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: ' عنوان ',
          labelStyle: TextStyle(
            fontFamily: 'GM',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: focusGuard1.hasFocus ? const Color(0xff18DAA3) : const Color(0xffC5C5C5),
          ),
          constraints: const BoxConstraints(maxHeight: 46, maxWidth: 340),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 3,
              color: Color(0xffC5C5C5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 3,
              color: Color(0xff18DAA3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getcommentField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        focusNode: focusGuard2,
        controller: _commentTextController,
        maxLines: 2,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: ' توضیحات ',
          labelStyle: TextStyle(
            fontFamily: 'GM',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: focusGuard2.hasFocus ? const Color(0xff18DAA3) : const Color(0xffC5C5C5),
          ),
          constraints: const BoxConstraints(minHeight: 46, maxWidth: 340),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 3,
              color: Color(0xffC5C5C5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 3,
              color: Color(0xff18DAA3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTaskTypeList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        itemCount: taskTypeList.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _taskType = taskTypeList[index];
              });
            },
            child: Container(
              width: 125,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (_taskType == taskTypeList[index]) ? const Color(0xff18DAA3) : Colors.red,
                  width: (_taskType == taskTypeList[index]) ? 3 : 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Image.asset(taskTypeList[index].imageAddress),
                  Text(
                    taskTypeList[index].name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'SM',
                      color: Color(0xff18DAA3),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  CustomHourPicker _getTaskTime() {
    return CustomHourPicker(
      title: '      زمان تسک را انتخاب کنید',
      positiveButtonText: 'ثبت تسک                ',
      negativeButtonText: '',
      titleStyle: const TextStyle(
        color: Color(0xff18DAA3),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'SM',
      ),
      positiveButtonStyle: const TextStyle(
        color: Color(0xff18DAA3),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'SM',
      ),
      negativeButtonStyle: const TextStyle(
        color: Colors.red,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'SM',
      ),
      onPositivePressed: (context, time) {
        _taskTime = time;
        setState(() {
          if (_getTask(_titleTextController.text, _commentTextController.text)) {
            Navigator.pop(context);
          }
        });
      },
      onNegativePressed: ((context) {}),
      elevation: 2,
    );
  }

  bool _getTask(String taskTitle, String? taskComment) {
    if (taskTitle == '') {
      _errorLine = 'عنوان حتما باید پر شود';
      return false;
    } else if (_taskTime == null) {
      {
        _errorLine = 'زمان تسک را تعیین کنید';
        return false;
      }
    } else {
      Task task =
          Task(title: taskTitle, comment: taskComment!, time: _taskTime!, taskType: _taskType ?? taskTypeList[0]);
      _taskBox.add(task);
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.text = '';
    _commentTextController.text = '';
    _errorLine = '';
  }
}
