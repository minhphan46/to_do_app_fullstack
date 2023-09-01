import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_mobi/features/task/domain/entities/task.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_event.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_state.dart';
import 'package:to_do_mobi/features/task/presentation/widgets/loading_column.dart';
import 'package:to_do_mobi/features/task/presentation/widgets/task_card.dart';
import '../../widgets/my_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textControler = TextEditingController();

  void getTasks(BuildContext context) {
    BlocProvider.of<RemoteTasksBloc>(context).add(const GetTasks());
  }

  @override
  void initState() {
    super.initState();
    getTasks(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteTasksBloc, RemoteTasksState>(
      listener: (context, state) {
        if (state is RemoteTasksError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
            ),
          );
        } else if (state is RemoteCreatedTask) {
          getTasks(context);
        } else if (state is RemoteUpdatedTask) {
          getTasks(context);
        } else if (state is RemoteRemovedTask) {
          getTasks(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state),
          appBar: _buildAppBar(),
          floatingActionButton: _buildFloatingActionButton(context),
        );
      },
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
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          getTasks(context);
        },
        icon: const Icon(
          Icons.refresh,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            //navigator to save page
          },
          icon: const Icon(
            Icons.save,
            color: Colors.black,
          ),
        ),
      ],
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

  _buildBody(RemoteTasksState state) {
    switch (state.runtimeType) {
      case RemoteTasksError:
        return const Center(child: Icon(Icons.error));
      case RemoteTasksLoading:
        return const Center(child: LoadingColumn(message: "Loading"));
      case RemoteUpdatingTask:
        return const Center(child: LoadingColumn(message: "Updating"));
      case RemoteCreatingTask:
        return const Center(child: LoadingColumn(message: "Creating"));
      case RemoteRemovingTask:
        return const Center(child: LoadingColumn(message: "Removing"));
      case RemoteTasksDone:
        return ListView.builder(
          itemCount: state.tasks!.length,
          itemBuilder: (_, index) {
            return TaskCard(
              task: state.tasks![index],
            );
          },
        );
      default:
        return const Center(child: Icon(Icons.refresh));
    }
  }

  void _onSaveTask(BuildContext context) {
    TaskEntity newTask = TaskEntity(
      title: _textControler.text.trim(),
      done: false,
    );
    BlocProvider.of<RemoteTasksBloc>(context).add(CreateTask(newTask));
    _textControler.clear();
  }

  void _createTask(BuildContext context) async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (ctx) => MyDiaLog(
        textControler: _textControler,
        onSave: () => _onSaveTask(context),
        title: "Add a new task",
      ),
    );
  }
}
