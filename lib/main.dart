import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/registro/registro_bloc.dart';
import 'package:hdv_ipark/ui/home/init.dart';
import 'ui/home/home.dart';
import 'blocs/sesion/sesion_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String home = Home.routeName;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SesionBloc(),
        ),
        BlocProvider(
          create: (context) => RegistroBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'hdv ipark',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          home: (context) => const Home(),
        },
        home: const Init(),
      ),
    );
  }
}
