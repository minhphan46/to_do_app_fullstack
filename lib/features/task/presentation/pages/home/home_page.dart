import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_state.dart';
import 'package:to_do_mobi/features/task/presentation/widgets/task_card.dart';

import '../../../domain/entities/task.dart';
import '../../bloc/task/remote/remote_task_event.dart';
import '../../widgets/my_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        "To Do",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        createTask(context);
      },
      backgroundColor: Colors.white,
      shape:
          const StadiumBorder(side: BorderSide(color: Colors.black, width: 3)),
      child: const Icon(
        Icons.add,
        color: Colors.black,
        size: 30,
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteTasksBloc, RemoteTasksState>(
      builder: (context, state) {
        if (state is RemoteTasksLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is RemoteTasksError) {
          return const Center(
            child: Icon(Icons.error),
          );
        } else if (state is RemoteTasksDone) {
          return ListView.builder(
            itemCount: state.tasks!.length,
            itemBuilder: (_, index) {
              return TaskCard(
                task: state.tasks![index],
                deleteTask: (context, task) {
                  _onRemoveTask(context, task);
                },
              );
            },
          );
        } else {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }
      },
    );
  }

  void deleteTask(TaskEntity task) {
    //_myListTasks.deleteTask(task);
  }

  void saveTask() {
    // _myListTasks.addTask(_controler.text.trim());
    // _controler.clear();
  }

  void createTask(BuildContext ctx) {
    showDialog(
      context: ctx,
      useRootNavigator: false,
      builder: (ctx) => MyDiaLog(
        controler: _controler,
        onSave: saveTask,
        title: "Add a new task",
      ),
    );
  }

  void _onRemoveTask(BuildContext context, TaskEntity task) {
    BlocProvider.of<RemoteTasksBloc>(context).add(DeleteTask(task.id!));
  }
}
