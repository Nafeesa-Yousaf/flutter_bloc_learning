import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/screen/todo_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TodoBloc())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 66, 83),
        ),
      ),
      home: TodoScreen(),
    );
  }
}
