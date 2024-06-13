import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../model/Usuario.dart';
import '../../repository/registro/api.dart';
import '../../repository/registro/repositorio.dart';
part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  final Repositorio repositorio = Repositorio(ApiRegistro());
  RegistroBloc() : super(NoRegistrado()) {
    on<Registrar>((event, emit) async {
      if (state is Registrando) return;
      emit(Registrando());
      try {
        await repositorio.registrar(event.usuario);
        emit(Registrado(""));
      } catch (e) {
        emit(ErrorRegistro("Usuario no registrado"));
      }
    });
  }
}
