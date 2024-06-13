import 'package:hdv_ipark/repository/registro/api.dart';
import '../../model/Usuario.dart';

class Repositorio {

  final RegistroApi _registroApi;

  Repositorio(this._registroApi);

  Future<Usuario> registrar(Usuario usuario) {
    return _registroApi.registrar(usuario);
  }

}