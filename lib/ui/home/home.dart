import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/Estacionamiento.dart';
import 'package:hdv_ipark/model/Usuario.dart';
import '../../main.dart';
import 'drawer_menu.dart';

import 'package:hdv_ipark/globals.dart' as globals;

class Home extends StatefulWidget {
  static const String routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _pantallaHomeState();
}

// ignore: camel_case_types
class _pantallaHomeState extends State<Home> {

  late Future<List<Estacionamiento>> parkings;
  //late Location location;
  late Usuario usuario = Usuario.secundario();

  String puerto = globals.puerto;
  String dominio = globals.dominio;


  @override
  void initState() {
    super.initState();
  }

  String _saludar() {
    final DateTime now = DateTime.now();
    String? nombre = usuario.nombres;
    if (now.hour < 12) {
      return '!Buenos dias $nombre¡';
    }
    return '!Buenas tardes $nombre¡';
  }

  Future<Usuario> _obtenerUsuario() async {
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
      imeiCelular: prefs.getString('imeiCelular'),
      serieCelular: prefs.getString('serieCelular}'),
      keySession: prefs.getInt('keySession'),
      id: prefs.getInt('id'),
    );
    return usuario;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          _obtenerUsuario(), // Llama a la función asíncrona para obtener usuario
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Cuando la operación asíncrona está completa
          usuario = snapshot.data as Usuario; // Obtén el valor de usuario
          /*_loadPlacas(usuario).then((value) {
              MyApp.placas.clear();
              MyApp.placas.addAll(value);
          });*/
          // Ahora puedes utilizar 'usuario' en el build
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title: const Text(
                "IPark",
                style: TextStyle(
                  color: Color.fromARGB(255, 17, 70, 151),
                  fontFamily: 'Raleway',
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 17, 70, 151), size: 50),
            ),
            endDrawer: const DrawerMenu(),
            backgroundColor: Colors.cyan,

            body: SizedBox(
              height: 800,
              child: Card(
                color: Colors.cyan,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 10.0, top: 100),
                        height: 30,
                        width: 300,
                        alignment: Alignment.topLeft,
                        child: Text(
                          _saludar(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 17, 70, 151),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        height: 80,
                        width: 300,
                        child: const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "¿Para dónde vamos?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 17, 70, 151),
                              fontSize: 30.0,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.0),
                        width: 250,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            //_getParkings();
                            Navigator.pushNamed(context, MyApp.listParking);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              ),
                            ),
                            backgroundColor: const Color.fromARGB(255, 17, 70, 151),
                          ),
                          child: const Text(
                            "ESTACIONAMIENTOS CERCANOS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.0),
                        width: 250,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            //Navigator.pushNamed(context, MyApp.scanner);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              ),
                            ),
                            backgroundColor: const Color.fromARGB(255, 17, 70, 151),
                          ),
                          child: const Text(
                            "PAGAR O VALIDAR TICKET",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.0),
                        width: 250,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              ),
                            ),
                            backgroundColor: const Color.fromARGB(255, 17, 70, 151),
                          ),
                          child: const Text(
                            " EN UNA!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 100.0),
                        height: 80,
                        width: 300,
                        child: const Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Version ${MyApp.version} Build ${MyApp.buildVersion}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 17, 70, 151),
                              fontSize: 15.0,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // This trailing comma makes auto-formatting nicer for build methods.
          );
        } else {
          // Mientras la operación asíncrona está en progreso, muestra un indicador de carga u otra UI
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
