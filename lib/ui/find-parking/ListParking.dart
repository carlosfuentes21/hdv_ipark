import 'package:flutter/material.dart';
import '../../model/Estacionamiento.dart';
import 'package:hdv_ipark/ui/find-parking/DescriptionParking.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:io';
import 'package:hdv_ipark/globals.dart' as globals;

class ListParking extends StatefulWidget {
  static const String routeName = '/find_parking';
  const ListParking({Key? key}) : super(key: key);

  @override
  State<ListParking> createState() => _pantallaListParkingState();
}

// ignore: camel_case_types
class _pantallaListParkingState extends State<ListParking> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadParkings().then((value) {
      setState(() {
        estacionamientos.addAll(value);
      });
    });
  }

  late TextEditingController _searchController;
  late List<Estacionamiento> estacionamientos = <Estacionamiento>[];

  String puerto = globals.puerto;
  String dominio = globals.dominio;

  // Función para verificar y solicitar permisos de ubicación
  Future<bool> _checkPermissions() async {
    if (!(await Permission.location.isGranted)) {
      var status = await Permission.location.request();
      if (status == PermissionStatus.denied) {
        // El usuario ha denegado los permisos de ubicación
        print('Permiso de ubicación denegado por el usuario');
        return false;
      }
    }
    return true;
  }

  Future<List<Estacionamiento>> _loadParkings() async {
    final hasPermission = await _checkPermissions();
    if (!hasPermission) {
      return [];
    }

    var registros = <Estacionamiento>[];
    try {
      final position = await _geolocatorPlatform.getCurrentPosition();
      var longitud = position.longitude;
      var latitud = position.latitude;

      var url = Uri.parse('$dominio/api/v1/parking/nearby');

      var response = await http.post(url, body: {
        'myLatitude': latitud.toString().replaceAll('.', ','),
        'myLongitude': longitud.toString().replaceAll('.', ','),
        'radiusInkilometer': '500'
      }).timeout(const Duration(seconds: 30));

      var statusCode = response.statusCode;
      var json = response.body;
      print("response obtener parqueaderos $json");

      if (statusCode == HttpStatus.ok) {
        bool jsonResponseStatus = jsonDecode(json)['status'];
        if (!jsonResponseStatus) {
          return null!;
        }
        var jsonDatos = jsonDecode(json)['data'];
        print(jsonDatos);
        if (jsonDatos is List) {
          for (var jsonData in jsonDatos) {
            var estacionamiento = Estacionamiento.fromJson(jsonData);
            print(estacionamiento.name);
            registros.add(estacionamiento);
          }
        }
      }
    } catch (e) {
      print("Error al obtener listar parqueaderos: $e");
      return [];
    }
    return registros;
  }

  @override
  Widget build(BuildContext context) {
    var filteredList = estacionamientos
        .where((parking) => parking.name!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 17, 70, 151), size: 30),
      ),
      backgroundColor: Colors.cyan,
      body: SingleChildScrollView(
        child: Card(
          color: Colors.cyan,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  height: 80,
                  width: 300,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Estacionamientos cercanos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 70, 151),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  height: 50,
                  width: 300,
                  alignment: Alignment.topCenter,
                  child: _createInputSearch(),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  height: 550,
                  width: 350,
                  //alignment: Alignment.topCenter,
                  child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print('index');
                        final tempWidget =
                            _createCardParking(estacionamientos[index]);
                        return tempWidget;
                      }
                      //children: _cargarEstacionamientos(),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createInputSearch() {
    return TextField(
      controller: _searchController,
      onChanged: (text) {
        setState(() {}); // Actualiza la UI al cambiar el texto
      },
      //keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Buscar',
        labelText: 'BUSCAR',
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }

  Widget _createCardParking(Estacionamiento estacionamiento) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DescriptionParking(estacionamiento)));
        //Navigator.pushNamed(context, MyApp.description_parking);
      },
      child: Card(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.circle, color: Colors.green),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.black26,
                ),
                SizedBox(
                  height: 30,
                  width: 60,
                  child: Align(
                      alignment: Alignment.center,
                      child: _getText(estacionamiento.distanceKm!.toStringAsFixed(1))),
                ),
                const VerticalDivider(
                  color: Colors.black26,
                ),
                SizedBox(
                  height: 30,
                  width: 190,
                  child: Align(
                      alignment: Alignment.center,
                      child: _getText(estacionamiento.name!)),
                ),
                const VerticalDivider(
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 17, 70, 151),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          fontSize: 15.0,
          fontWeight: FontWeight.bold),
    );
  }

}
