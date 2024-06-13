import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../model/Usuario.dart';
import '../../repository/login/api.dart';
import '../../repository/login/repositorio.dart';
part 'sesion_event.dart';
part 'sesion_state.dart';

class SesionBloc extends Bloc<SesionEvent, SesionState> {
  final Repositorio repositorio = Repositorio(ApiUsuario());
  SesionBloc() : super(SesionNoIniciada()) {
  
    on<IniciarSesion>((event, emit) async {
      if (state is IniciandoSesion) return;
      emit(IniciandoSesion());
      try {
        await repositorio.iniciarSesion(event.usuario);
        emit(SesionIniciada(""));
      } catch (e) {
        emit(ErrorIniciadoSesion("Error de datos"));
      }
    });

    on<CerrarSesion>((event, emit) async {
      try {
        await repositorio.cerrarSesion(event.usuario);
        emit(SesionNoIniciada());
      } catch (e) {
        emit(ErrorIniciadoSesion("Error cerrar sesion"));
      }
    });
  }
}
