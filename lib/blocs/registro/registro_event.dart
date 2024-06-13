part of 'registro_bloc.dart';

@immutable
abstract class RegistroEvent {}

class Registrar extends RegistroEvent {
  final Usuario usuario;
  Registrar(this.usuario);
}