import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../model/Usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hdv_ipark/globals.dart' as globals;

abstract class RegistroApi {
  const RegistroApi();
  Future<Usuario> registrar(Usuario usuario);
}

class ApiRegistro extends RegistroApi {
  late Uri url;
  
  String dominio = globals.dominio;

  @override
  Future<Usuario> registrar(Usuario usuario) async {
    url = Uri.parse('$dominio/api/v1/user');
    var response = await http.post(url, body: {
      'rut': usuario.rut,
      'digVer': usuario.digVer,
      'mail': usuario.mail,
      'nombres': usuario.nombres,
      'apellidos': usuario.apellidos,
      'telefono': usuario.telefono,
      'claveAcceso': usuario.claveAcceso,
      'ciudad': usuario.ciudad,
      'estado': usuario.estado,
      'imeiCelular': '000000',
      'serieCelular': '000000',
      'versionApp': '1.0',
    });
    
    var status = response.statusCode;
    print("response de registro $status");
    var json = response.body;
    print("response de registro $json");

    if (response.statusCode != HttpStatus.ok) {
      Map<String, dynamic> jsonData = jsonDecode(json)['data'];
      Usuario userResponse = Usuario.fromJson(jsonData);
      if (userResponse.keySession == null) {
        throw Exception();
      } else {
        _savePreferences(usuario, userResponse);
        return usuario;
      }
    }

    Map<String, dynamic> jsonData = jsonDecode(json)['data'];
    Usuario userResponse = Usuario.fromJson(jsonData);
    _savePreferences(usuario, userResponse);
    return usuario;
  }

  void _savePreferences(Usuario usuario, Usuario userResponse) async {
    var a = userResponse.apellidos;
    print("__________________________ $a");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rut', userResponse.rut.toString());
    prefs.setString('digVer', userResponse.digVer.toString());
    prefs.setString('mail', userResponse.mail.toString());
    prefs.setString('nombres', userResponse.nombres.toString());
    prefs.setString('apellidos', userResponse.apellidos.toString());
    prefs.setString('telefono', userResponse.telefono.toString());
    prefs.setString('claveAcceso', usuario.claveAcceso.toString());
    prefs.setString('imeiCelular', usuario.imeiCelular.toString());
    prefs.setString('serieCelular', usuario.serieCelular.toString());
    prefs.setInt('keySession', userResponse.keySession!);
    prefs.setInt('id', userResponse.id!);
  }

}
