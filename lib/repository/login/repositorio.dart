import 'package:hdv_ipark/repository/login/api.dart';
import '../../model/Usuario.dart';

class Repositorio {

  final UsuarioApi _usuarioApi;

  Repositorio(this._usuarioApi);

  Future<Usuario> iniciarSesion(Usuario usuario) {
    return _usuarioApi.iniciarSesion(usuario);
  }

  Future<bool> cerrarSesion(Usuario usuario) {
    return _usuarioApi.cerrarSesion(usuario);
  }

}