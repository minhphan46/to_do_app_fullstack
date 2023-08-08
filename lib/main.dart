import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_mobi/config/theme/app_theme.dart';
import 'package:to_do_mobi/features/task/presentation/bloc/task/remote/remote_task_bloc.dart';
import 'package:to_do_mobi/features/task/presentation/pages/home/home_page.dart';
import 'package:to_do_mobi/injection_container.dart';

import 'features/task/presentation/bloc/task/remote/remote_task_event.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteTasksBloc>(
      create: (context) => sl()..add(const GetTasks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do App',
        theme: theme(),
        home: const HomePage(),
      ),
    );
  }
}
