import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdv_ipark/blocs/sesion/sesion_bloc.dart';
import 'package:hdv_ipark/ui/home/home.dart';
import 'package:hdv_ipark/ui/home/init.dart';
//import 'package:hdv_ipark/ui/vehiculo/ListarPlacas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../model/Usuario.dart';
//import '../pago/ListarTarjetas.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _PantallaDrawerState();
}

class _PantallaDrawerState extends State<DrawerMenu> {
  Future cerrarSesion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Usuario usuario = Usuario.secundario(
      rut: prefs.getString('rut'),
      digVer: prefs.getString('digVer'),
      mail: prefs.getString('mail'),
      nombres: prefs.getString('nombres'),
      apellidos: prefs.getString('apellidos'),
      telefono: prefs.getString('telefono'),
      claveAcceso: prefs.getString('claveAcceso'),
      imeiCelular: prefs.getString('imeiCelular'),
      serieCelular: prefs.getString('SerieCelular}'),
      keySession: prefs.getInt('keySession'),
    );
    BlocProvider.of<SesionBloc>(context).add(CerrarSesion(usuario));
  }

  void cleanData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rut', '');
    prefs.setString('digVer', '');
    prefs.setString('mail', '');
    prefs.setString('nombres', '');
    prefs.setString('apellidos', '');
    prefs.setString('telefono', '');
    prefs.setString('claveAcceso', '');
    prefs.setString('keySession', '');
  }

  @override
  Widget build(BuildContext context) {
    StylishDialog dialog = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
    );

    return BlocListener<SesionBloc, SesionState>(
      listener: (context, state) {
        // do stuff here based on BlocA's state
        if (state is ErrorIniciadoSesion) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const Home()));
        } else if (state is SesionNoIniciada) {
          cleanData();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const Init()),
              (route) => false);
        }
      },
      child: Drawer(

        backgroundColor: const Color.fromARGB(255, 244, 244, 244),

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(),
            /*_buildDrawerItem(icon: Icons.home, text: 'Home', onTap: () => {
                Navigator.pushNamed(context, MyApp.home)
            }),*/
            _buildDrawerItem(
                icon: Icons.account_circle,
                text: 'Perfil',
                onTap: () => {
                      //Navigator.pushReplacementNamed(context, MyApp.profile)
                    }),
            /*_buildDrawerItem(
                icon: Icons.payment_outlined,
                text: 'Mis metodos de pago',
                onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ListMetodosPago("")))
                    }),*/
            _buildDrawerItem(
                icon: Icons.car_repair,
                text: 'Mis vehiculos',
                onTap: () => {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ListPlacas("")))
                    }),
            _buildDrawerItem(
                icon: Icons.money,
                text: 'Mi abonado',
                onTap: () => {
                      //Navigator.pushReplacementNamed(context, MyApp.contacts)
                    }),
            const Divider(),
            _buildDrawerItem(
                icon: Icons.help,
                text: 'Ayuda',
                onTap: () => {
                      //Navigator.pushReplacementNamed(context, MyApp.contacts)
                    }),
            _buildDrawerItem(
                icon: Icons.close,
                text: 'Cerrar sesion',
                onTap: () => {
                      //Navigator.pushReplacementNamed(context, MyApp.contacts)
                      _showAlertDialog(dialog)
                      //cerrarSesion(),
                    }),
            /*ListTile(
              title: const Text('App version 1.0.0'),
              onTap: () {},
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
        //margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        margin: EdgeInsets.zero,
        //padding: EdgeInsets.zero,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/hdv-park.jpeg'))),
        child: Stack(children: const <Widget>[
          /*Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Compilación Movil",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  )
                )
          ),*/
        ]));
  }

  Widget _buildDrawerItem(
      {IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _showAlertDialog(StylishDialog dialog) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: const Text('Cerrar sesion'),
            content: const Text('deseas cerrar sesion?'),
            //actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  dialog.dismiss();
                  //Navigator.pop(context, false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                  //dialog.titleText = "Cerrando sesion...";
                  dialog.show();
                  cerrarSesion();
                },
                child: const Text('Si'),
              ),
            ],
          );
        });
  }
}
