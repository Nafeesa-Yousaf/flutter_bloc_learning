import 'package:favourite_app_bloc/bloc/favourite/favourite_bloc.dart';
import 'package:favourite_app_bloc/data/repo/favourite_repo.dart';
import 'package:favourite_app_bloc/screen/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (Context) => FavouriteBloc(FavouriteRepo())),
      ],
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FavouriteScreen(),
    );
  }
}
