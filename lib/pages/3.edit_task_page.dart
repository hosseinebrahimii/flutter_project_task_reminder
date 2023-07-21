import 'package:flutter/material.dart';
import 'package:flutter_project_task_reminder/data/classes/task.dart';
import 'package:flutter_project_task_reminder/data/models/task_type_list.dart';

import 'package:time_pickerr/time_pickerr.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.task});
  final Task task;
  @override
  State<EditTaskPage> createState() => _SetTaskWidgetState();
}

late TextEditingController _titleTextController;
late TextEditingController _commentTextController;
FocusNode focusGuard1 = FocusNode();
FocusNode focusGuard2 = FocusNode();
String _errorLine = '';

class _SetTaskWidgetState extends State<EditTaskPage> {
  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController(text: widget.task.title);
    _commentTextController = TextEditingController(text: widget.task.comment);
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
                  height: 30,
                ),
                _gettitleField(),
                const SizedBox(
                  height: 30,
                ),
                _getcommentField(),
                const SizedBox(
                  height: 30,
                ),
                _getTaskTime(),
                const SizedBox(
                  height: 30,
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
                _getsaveTaskButton(),
                const SizedBox(
                  height: 20,
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
      height: 150,
      child: ListView.builder(
        itemCount: taskTypeList.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                widget.task.taskType = taskTypeList[index];
              });
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (widget.task.taskType == taskTypeList[index]) ? const Color(0xff18DAA3) : Colors.red,
                  width: (widget.task.taskType == taskTypeList[index]) ? 3 : 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Image.asset(taskTypeList[index].imageAddress),
                  const Spacer(),
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

  ElevatedButton _getsaveTaskButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff18DAA3),
        foregroundColor: Colors.white,
        minimumSize: const Size(200, 45),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: const TextStyle(
          fontFamily: 'SM',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        setState(() {
          if (_getTask(_titleTextController.text, _commentTextController.text)) {
            Navigator.pop(context);
          }
        });
      },
      child: const Text('ویرایش تسک'),
    );
  }

  CustomHourPicker _getTaskTime() {
    return CustomHourPicker(
      title: '              زمان تسک را انتخاب کنید',
      positiveButtonText: 'ثبت زمان                           ',
      negativeButtonText: 'انصراف',
      titleStyle: const TextStyle(
        color: Color(0xff18DAA3),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'SM',
      ),
      positiveButtonStyle: const TextStyle(
        color: Color(0xff18DAA3),
        fontSize: 18,
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
        widget.task.time = time;
      },
      onNegativePressed: ((context) {}),
      elevation: 2,
      date: widget.task.time,
    );
  }

  bool _getTask(String taskTitle, String? taskComment) {
    if (taskTitle == '') {
      _errorLine = 'عنوان حتما باید پر شود';
      return false;
    } else {
      widget.task.title = taskTitle;
      widget.task.comment = taskComment!;
      widget.task.save();
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _errorLine = '';
  }
}
