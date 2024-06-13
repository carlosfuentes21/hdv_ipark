part of 'sesion_bloc.dart';

@immutable
abstract class SesionState {}

class SesionNoIniciada extends SesionState {

}
class ErrorIniciadoSesion extends SesionState {
  final String mensajeError;
  ErrorIniciadoSesion(this.mensajeError);
}

class SesionIniciada extends SesionState {
  final String nombreUsuario;
  SesionIniciada(this.nombreUsuario);
}

class IniciandoSesion extends SesionState {}
