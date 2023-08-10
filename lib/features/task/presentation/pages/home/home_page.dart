import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_state.dart';
import 'package:to_do_mobi/features/task/presentation/widgets/task_card.dart';

import '../../../domain/entities/task.dart';
import '../../bloc/task/remote/remote_task_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
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

  void _onRemoveTask(BuildContext context, TaskEntity task) {
    print(task.title);
    BlocProvider.of<RemoteTasksBloc>(context).add(DeleteTask(task.id!));
  }
}
