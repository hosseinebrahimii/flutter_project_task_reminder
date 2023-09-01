import 'package:flutter/material.dart';
import 'package:flutter_project_task_reminder/models/task.dart';
import 'package:flutter_project_task_reminder/pages/1.tasks_page.dart';
import 'package:flutter_project_task_reminder/pages/3.edit_task_page.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class ShowTaskWidget extends StatefulWidget {
  const ShowTaskWidget({super.key, required this.task});
  final Task task;
  @override
  State<ShowTaskWidget> createState() => _ShowTaskWidgetState();
}

var taskRemovingListNotifier = ValueNotifier<List<Task>>([]);

class _ShowTaskWidgetState extends State<ShowTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return _getBlock(widget.task);
  }

  Column _getBlock(contex) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 132,
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(widget.task.taskType.imageAddress),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _getTitlesAndTickRow(),
                    const Spacer(),
                    _getTimeAndEditRow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _getTitlesAndTickRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.task.title,
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.task.comment,
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium,
              )
            ],
          ),
        ),
        const Spacer(),
        MSHCheckbox(
          size: 30,
          value: widget.task.isDone,
          colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
            checkedColor: const Color(0xff18DAA3),
          ),
          style: MSHCheckboxStyle.fillFade,
          onChanged: (selected) {
            setState(() {
              widget.task.isDone = selected;
              widget.task.save();
              taskRemovingListNotifier.value = taskBox.values.where((element) => element.isDone == true).toList();
            });
          },
        ),
      ],
    );
  }

  Row _getTimeAndEditRow() {
    return Row(
      children: [
        Container(
          height: 28,
          width: 90,
          decoration: BoxDecoration(
            color: const Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: [
                Image.asset('images/icon_time.png'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  (widget.task.time.minute < 10)
                      ? '${widget.task.time.hour}:0${widget.task.time.minute}'
                      : '${widget.task.time.hour}:${widget.task.time.minute}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            focusGuard1 = FocusNode();
            focusGuard2 = FocusNode();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => EditTaskPage(
                      task: widget.task,
                    )),
              ),
            );
          },
          child: Container(
            height: 28,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xffE2F6F1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  Image.asset('images/icon_edit.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'ویرایش',
                    style: TextStyle(
                      color: Color(0xff18DAA3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
