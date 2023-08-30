import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_event.dart';
import 'my_dialog.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  TaskCard({required this.task, super.key});

  final _titleControler = TextEditingController();

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
                  onPressed: (context) {
                    deleteTask(task, context);
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
                    updateCheck(task, context);
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
                  showDialogUpdateTask(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

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

  void deleteTask(TaskEntity task, BuildContext context) {
    BlocProvider.of<RemoteTasksBloc>(context).add(DeleteTask(task.id!));
    showSnackBar(context, "Deleted task: ${task.title!}");
  }

  void updateTitle(TaskEntity task, BuildContext context) {
    TaskEntity newTask = task.copyWith(title: _titleControler.text.trim());
    BlocProvider.of<RemoteTasksBloc>(context).add(UpdateTask(newTask));
    _titleControler.clear();
  }

  void updateCheck(TaskEntity task, BuildContext context) {
    TaskEntity newTask = task.copyWith(done: !task.done!);
    BlocProvider.of<RemoteTasksBloc>(context).add(UpdateTask(newTask));
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(text),
      ),
    );
  }

  void showDialogUpdateTask(BuildContext ctx) {
    _titleControler.text = task.title!;
    showDialog(
      context: ctx,
      useRootNavigator: false,
      builder: (context) => MyDiaLog(
        textControler: _titleControler,
        onSave: () => updateTitle(task, ctx),
        title: "Update task",
      ),
    );
  }
}
