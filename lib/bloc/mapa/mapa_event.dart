part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnCambioUbicacion extends MapaEvent {
  final LatLng nuevaUbicacion;

  OnCambioUbicacion(this.nuevaUbicacion);
}

class OnMarcarRecorrido extends MapaEvent {}

class OnSeguirUbicacion extends MapaEvent {}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;

  OnMovioMapa(this.centroMapa);
}
