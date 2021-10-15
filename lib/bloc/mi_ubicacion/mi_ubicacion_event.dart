part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

class OnUbicacioncambio extends MiUbicacionEvent {
  final LatLng ubicacion;

  OnUbicacioncambio(this.ubicacion);
}
