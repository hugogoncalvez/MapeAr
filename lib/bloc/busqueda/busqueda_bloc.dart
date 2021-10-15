import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(const BusquedaState()) {
    on<OnActivarMarcadorManual>(_onActivarMarcadorManual);
    on<OnDesactivarMarcadorManual>(_onDesactivarMarcadorManual);
  }

  void _onActivarMarcadorManual(
      OnActivarMarcadorManual event, Emitter<BusquedaState> emit) {
    emit(state.copyWith(seleccionManual: true));
  }

  void _onDesactivarMarcadorManual(
      OnDesactivarMarcadorManual event, Emitter<BusquedaState> emit) {
    emit(state.copyWith(seleccionManual: false));
  }
}
