import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/sesion/sesion_bloc.dart';
import '../home/home.dart';
import '../registro/Registrar.dart';
import '../../model/Usuario.dart';

class Init extends StatefulWidget {
  static const String routeName = '/init';
  const Init({Key? key}) : super(key: key);

  @override
  State<Init> createState() => _pantallaInitState();
}

// ignore: camel_case_types
class _pantallaInitState extends State<Init> {

@override
  void initState() {
    super.initState();
    login();
  }


Future login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Usuario usuario = Usuario.secundario(
      rut: prefs.getString('rut'),
      digVer: prefs.getString('digVer'),
      mail: prefs.getString('mail'),
      nombres: prefs.getString('nombres'),
      apellidos: prefs.getString('apellidos'),
      telefono: prefs.getString('telefono'),
      claveAcceso: prefs.getString('claveAcceso'),
      ciudad: prefs.getString('ciudad'),
      estado: prefs.getString('estado'),
      imeiCelular:prefs.getString('imeiCelular'),
      serieCelular:prefs.getString('serieCelular}'),
      keySession: prefs.getInt('keySession'),
      id: prefs.getInt("id"),
    );

    BlocProvider.of<SesionBloc>(context).add(IniciarSesion(usuario));
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.cyan,
      body: BlocListener<SesionBloc, SesionState>(
        listener: (context, state) {
          if (state is ErrorIniciadoSesion) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Registro()));
          } else if (state is SesionIniciada) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Home()));
          }
        },
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'IPark',
                style: TextStyle(
                  color: Color.fromARGB(255, 17, 70, 151),
                  fontFamily: 'Raleway',
                  fontSize: 85.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
