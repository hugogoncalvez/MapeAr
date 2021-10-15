import 'package:flutter/material.dart' show Colors;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapear/themes/uber_map.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState()) {
    on<OnMapaListo>(_onMapaListo);
    on<OnCambioUbicacion>(_onCambioUbicacion);
    on<OnMarcarRecorrido>(_onMarcarRecorrido);
    on<OnSeguirUbicacion>(_onSeguirUbicacion);
    on<OnMovioMapa>(_onMovioMapa);
  }
  // Controlador del mapa
  late GoogleMapController _mapController;

  //Polylines
  Polyline _miRuta = const Polyline(
      color: Colors.transparent, polylineId: PolylineId('mi_ruta'), width: 4);

  void _onMapaListo(OnMapaListo event, Emitter<MapaState> emit) {
    emit(state.copyWith(mapaListo: true));
  }

  void _onCambioUbicacion(OnCambioUbicacion event, Emitter<MapaState> emit) {
    if (state.seguirUbicacion) {
      moverCamara(event.nuevaUbicacion);
    }
    List<LatLng> puntos = [..._miRuta.points, event.nuevaUbicacion];
    _miRuta = _miRuta.copyWith(pointsParam: puntos);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = _miRuta;
    emit(state.copyWith(polylines: currentPolylines));
  }

  void _onMarcarRecorrido(OnMarcarRecorrido event, Emitter<MapaState> emit) {
    if (!state.dibujarRecorrido) {
      _miRuta = _miRuta.copyWith(colorParam: Colors.black54);
    } else {
      _miRuta = _miRuta.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = _miRuta;

    emit(state.copyWith(
        dibujarRecorrido: !state.dibujarRecorrido,
        polylines: currentPolylines));
  }

  void _onSeguirUbicacion(OnSeguirUbicacion event, Emitter<MapaState> emit) {
    if (!state.seguirUbicacion) {
      moverCamara(_miRuta.points[_miRuta.points.length - 1]);
    }
    emit(state.copyWith(seguirUbicacion: !state.seguirUbicacion));
  }

  void _onMovioMapa(OnMovioMapa event, Emitter<MapaState> emit) {
    emit(state.copyWith(ubicacionCentral: event.centroMapa));
  }

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      _mapController = controller;
      _mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final camaraUpdate = CameraUpdate.newLatLng(destino);
    _mapController.animateCamera(camaraUpdate);
  }
}
