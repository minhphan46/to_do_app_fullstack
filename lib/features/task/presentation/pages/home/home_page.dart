import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_event.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_state.dart';
import 'package:to_do_mobi/features/task/presentation/widgets/task_card.dart';
import '../../widgets/my_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _textControler = TextEditingController();

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
        _createTask(context);
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

  void _onSaveTask(BuildContext context) {
    TaskEntity newTask = TaskEntity(
      title: _textControler.text.trim(),
      done: false,
    );
    BlocProvider.of<RemoteTasksBloc>(context).add(CreateTask(newTask));
    _textControler.clear();
  }

  void _createTask(BuildContext ctx) {
    showDialog(
      context: ctx,
      useRootNavigator: false,
      builder: (ctx) => MyDiaLog(
        controler: _textControler,
        onSave: () => _onSaveTask(ctx),
        title: "Add a new task",
      ),
    );
  }
}
