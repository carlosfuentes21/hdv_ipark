part of 'sesion_bloc.dart';

@immutable
abstract class SesionEvent {}

class IniciarSesion extends SesionEvent {
  final Usuario usuario;
  IniciarSesion(this.usuario);
}

class CerrarSesion extends SesionEvent {
  final Usuario usuario;
  CerrarSesion(this.usuario);
}