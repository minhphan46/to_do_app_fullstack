import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  const TaskCard(this.task, {super.key});

  String getDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final dateToCheck = task.date!;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return DateFormat('kk:mm').format(task.date!);
    }
    return DateFormat('kk:mm - MM/dd').format(task.date!);
  }

  // final _titleControler = TextEditingController();
  // void updateTitle() {
  //   task.updateTitle(_titleControler.text.trim());
  //   _titleControler.clear();
  // }

  // void createTask(BuildContext ctx) {
  //   _titleControler.text = task.title.value;
  //   showDialog(
  //     context: ctx,
  //     useRootNavigator: false,
  //     builder: (ctx) => MyDiaLog(
  //       controler: _titleControler,
  //       onSave: updateTitle,
  //       title: "Update task",
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 30,
                right: 25,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 80,
                decoration: BoxDecoration(
                  color: task.color,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 25,
            right: 30,
          ),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => {
                    // deleteTask(task),
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
              child: ListTile(
                leading: Checkbox(
                  value: task.done,
                  tristate: true,
                  activeColor: task.color,
                  onChanged: (_) {
                    //task.changeDone();
                  },
                ), // icon o truoc tieu de
                title: Text(task.title!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      decoration: task.done!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    )),
                trailing: Text(
                  getDate(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                onLongPress: () {
                  //createTask(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
