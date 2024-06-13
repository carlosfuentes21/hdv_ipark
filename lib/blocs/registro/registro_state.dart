part of 'registro_bloc.dart';

@immutable
abstract class RegistroState {}

class NoRegistrado extends RegistroState {}

class ErrorRegistro extends RegistroState {
  final String mensajeError;
  ErrorRegistro(this.mensajeError);
}

class Registrado extends RegistroState {
  final String nombreUsuario;
  Registrado(this.nombreUsuario);
}

class Registrando extends RegistroState {}