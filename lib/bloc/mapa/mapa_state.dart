part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng ubicacionCentral;

  //polylines

  final Map<String, Polyline> polylines;

  MapaState(
      {this.mapaListo = false,
      this.dibujarRecorrido = false,
      polylines,
      this.seguirUbicacion = false,
      ubicacionCentral})
      : polylines = polylines ?? {},
        ubicacionCentral = ubicacionCentral ?? const LatLng(0, 0);

  MapaState copyWith(
          {bool? mapaListo,
          bool? dibujarRecorrido,
          Map<String, Polyline>? polylines,
          bool? seguirUbicacion,
          LatLng? ubicacionCentral}) =>
      MapaState(
          mapaListo: mapaListo ?? this.mapaListo,
          dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
          polylines: polylines ?? this.polylines,
          seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
          ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral);
}
