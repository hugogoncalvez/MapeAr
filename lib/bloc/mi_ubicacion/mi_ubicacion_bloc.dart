import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(const MiUbicacionState()) {
    on<OnUbicacioncambio>(_onUbicacionCambio);
  }
  void _onUbicacionCambio(
      OnUbicacioncambio event, Emitter<MiUbicacionState> emit) {
    emit(state.copyWith(existeUbicacion: true, ubicacion: event.ubicacion));
  }

  late StreamSubscription<Position> _positionSubscrption;

  void iniciarSeguimiento() {
    _positionSubscrption = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
        .listen((Position position) {
      final ubicacion = LatLng(position.latitude, position.longitude);
      add(OnUbicacioncambio(ubicacion));
    });
  }

  void cancelarSeguimiento() {
    _positionSubscrption.cancel();
  }
}
