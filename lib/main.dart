import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/registro/registro_bloc.dart';
import 'package:hdv_ipark/ui/home/init.dart';
import 'ui/home/home.dart';
import 'blocs/sesion/sesion_bloc.dart';
import 'ui/find-parking/ListParking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String home = Home.routeName;
  static const String listParking = ListParking.routeName;

   

  static const String version = "1.0.0";
  static const String buildVersion = "190722";

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
          listParking: (context) => const ListParking(),
        },
        home: const Init(),
      ),
    );
  }
}
