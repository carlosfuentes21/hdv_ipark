import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../model/Usuario.dart';
import 'package:hdv_ipark/globals.dart' as globals;

abstract class UsuarioApi {
  const UsuarioApi();
  Future<Usuario> iniciarSesion(Usuario usuario);
  Future<bool> cerrarSesion(Usuario usuario);
}

class ApiUsuario extends UsuarioApi {
  String puerto = globals.puerto;
  String dominio = globals.dominio;

  @override
  Future<Usuario> iniciarSesion(Usuario usuario) async {
    var url = Uri.parse('$dominio/api/v1/auth/login');
    var response = await http.post(url, body: {
      'keySession': '123456789012345',
      'mail': usuario.mail,
      'claveAcceso': usuario.claveAcceso,
      'imeiPos': '111111',
      'serieCelular': '1',
      'versionApp': '1',
    });
    var json = response.body;
    print("response de login $json");
    if (response.statusCode == HttpStatus.ok) {
      var status = jsonDecode(json)['status'];
      if (!status) {
        throw Exception();
      }
      
      return usuario;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> cerrarSesion(Usuario usuario) async {
    /*final Xml2Json xml2Json = Xml2Json();
    var url =
        Uri.parse('http://$dominio:$puerto/servicioweb.asmx/IPARK_CerrarLogin');

    var response = await http.post(url, body: {
      'key_session': usuario.keySession,
      'mail': usuario.mail,
      'claveAcceso': usuario.claveAcceso,
      'imeiPos': '',
      'SerieCelular': '',
      'VersionApp': '',
    });

    xml2Json.parse(response.body);
    var jsonString = xml2Json.toParker();
    var data = jsonDecode(jsonString);
    var json = data.toString().substring(9, data.toString().length - 1);
    print(json);

    if (response.statusCode == HttpStatus.ok) {
      String estatus = jsonDecode(json)['estatus'];

      if (estatus.compareTo("false") == 0) {
        return false;
      }
      return true;
    } else {
      throw Exception();
    }*/
    return false;
  }
}
