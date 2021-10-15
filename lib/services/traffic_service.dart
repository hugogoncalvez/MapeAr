import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  // Singleton

  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();

  final String _baseURL = 'https://api.mapbox.com/directions/v5/mapbox/driving';
  final String _apiKey =
      'pk.eyJ1IjoiaHVnb2dvbmNhbHZleiIsImEiOiJja3VzZnI5azgwMzZnMm5tcDlrNmZzYWRkIn0.kBLVcrgotf7I8WmvaN0QKw'; // apyKey de MapBox

  Future getCoordenadasInicioDestino(LatLng inicio, LatLng destino) async {
    print('inicio: $inicio');
    print('destino: $destino');

    final coordenadasString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';

    final url = '$_baseURL/$coordenadasString';

    final resp = await _dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': _apiKey,
      'language': 'es',
    });

    print(resp);
    return;
  }
}
