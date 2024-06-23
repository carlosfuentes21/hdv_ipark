import 'package:flutter/material.dart';
import 'package:hdv_ipark/model/Estacionamiento.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';

class DescriptionParking extends StatefulWidget {
  static const String routeName = '/description_parking';
  final Estacionamiento estacionamiento;
  const DescriptionParking(this.estacionamiento, {super.key});

  @override
  State<DescriptionParking> createState() => _pantallaDescriptionParkingState();
}

// ignore: camel_case_types
class _pantallaDescriptionParkingState extends State<DescriptionParking> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late Position position;
  @override
  void initState() {
    super.initState();
    _currendPosition();
  }

  void _currendPosition() async {
    position = await _geolocatorPlatform.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 17, 70, 151), size: 30),
      ),
      backgroundColor: Colors.cyan,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 500,
              width: 390,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                  ),
                ),
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _titulo(widget.estacionamiento.name!),
                      _direccion(widget.estacionamiento.addresss!),
                      _dividers(),
                      _loadString(
                          "Hay ${widget.estacionamiento.availablePlaces} estacionamientos disponibles",
                          Icons.car_repair),
                      _loadString(widget.estacionamiento.tariff!, Icons.paid),
                      _loadString(
                          widget.estacionamiento.schedule!, Icons.watch_later),
                      _getText("¿Que desea hacer?"),
                      SizedBox(
                        width: 300,
                        height: 70,
                        child: Row(
                          children: <Widget>[
                            _buttonWaze(widget.estacionamiento),
                            const Spacer(flex: 10),
                            _buttonMaps(widget.estacionamiento),
                            const Spacer(flex: 10),
                            _buttonPagar(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buttonWaze(Estacionamiento estacionamiento) {
    return Container(
      alignment: Alignment.center,
      width: 95,
      height: 70,
      child: ElevatedButton(
        onPressed: () async {
          bool isWaze = await MapLauncher.isMapAvailable(MapType.waze) ?? false;
          if (isWaze) {
            await MapLauncher.showDirections(
              mapType: MapType.waze,
              destination: Coords(
                  _parseCoords(estacionamiento.latitude.toString()),
                  _parseCoords(estacionamiento.longitude.toString())),
              origin: Coords(position.latitude!, position.longitude!),
            );
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('INFORMACION'),
                    content: const Text(
                        'El aplicativo WASE no se encuentra instalado?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                  ;
                });
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 17, 70, 151),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        ),
        child: const Text(
          "LLEVAME CON WAZE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  double _parseCoords(String cadena) {
    cadena = cadena.replaceAll(",", ".");
    return double.parse(cadena);
  }

  Widget _buttonMaps(Estacionamiento estacionamiento) {
    return Container(
      width: 95,
      height: 70,
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () async {
          bool isGoogle =
              await MapLauncher.isMapAvailable(MapType.google) ?? false;
          if (isGoogle) {
            await MapLauncher.showDirections(
              mapType: MapType.google,
              destination: Coords(
                  _parseCoords(estacionamiento.latitude.toString()),
                  _parseCoords(estacionamiento.longitude.toString())),
              origin: Coords(position.latitude!, position.longitude!),
            );
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('INFORMACION'),
                    content: const Text(
                        'El aplicativo GOOGLE MAPS no se encuentra instalado?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                  ;
                });
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 17, 70, 151),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        ),
        child: const Text(
          "LLEVAME CON GOOGLE MAPS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buttonPagar() {
    return Container(
      alignment: Alignment.center,
      width: 95,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          //Navigator.pushNamed(context, MyApp.scanner);
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 17, 70, 151),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        ),
        child: const Text(
          "PAGAR O VALIDAR TICKET",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getText(String opt) {
    return Text(
      opt,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Color.fromARGB(255, 17, 70, 151),
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
    );
  }

  Container _titulo(String name) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        height: 40,
        width: 300,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(255, 17, 70, 151),
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  SizedBox _direccion(String direccion) {
    return SizedBox(
      height: 30,
      width: 300,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          direccion,
          //"Av. Dos de Mayo 1099",
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromARGB(255, 17, 70, 151),
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container _dividers() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Color.fromARGB(255, 17, 70, 151)),
          bottom: BorderSide(width: 1, color: Color.fromARGB(255, 17, 70, 151)),
        ),
        color: Colors.white,
      ),
      //margin: EdgeInsets.only(left: 22),
      width: 300,
    );
  }

  Center _loadString(String cadena, IconData iconData) {
    return Center(
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loadIcon(iconData),
            const VerticalDivider(
              color: Colors.black26,
            ),
            SizedBox(
              height: 40,
              width: 270,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  cadena,
                  //"Hay 4  estacionamientos disponibles",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 17, 70, 151),
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _tarifa(
      String tarifaPrincipal, String tarifaAlterna, IconData iconData) {
    return Center(
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loadIcon(iconData),
            const VerticalDivider(
              color: Colors.black26,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    width: 270,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        tarifaPrincipal,
                        //"Hay 4  estacionamientos disponibles",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 17, 70, 151),
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 270,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        tarifaAlterna,
                        //"Hay 4  estacionamientos disponibles",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 17, 70, 151),
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadIcon(IconData iconData) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Align(
        alignment: Alignment.center,
        child: Icon(
          iconData,
          color: const Color.fromARGB(255, 17, 70, 151),
        ),
      ),
    );
  }
}
