import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapear/bloc/mapa/mapa_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapear/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapear/widget/widget_imports.dart';

class MapaPage extends StatefulWidget {
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (_, state) => crearMapa(state),
          ),
          MarcadorManual(),
          // TODO:  hacer el toggle cuando estoy manualmente o no
          const SafeArea(child: BarraBusqueda())
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnOcultarPolyline()
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    if (state.existeUbicacion) {
      final CameraPosition posicionInicial =
          CameraPosition(target: state.ubicacion, zoom: 15);
      mapaBloc.add(OnCambioUbicacion(state.ubicacion));
      return SafeArea(
        child: GoogleMap(
          initialCameraPosition: posicionInicial,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) =>
              mapaBloc.initMapa(controller),
          polylines: mapaBloc.state.polylines.values.toSet(),
          onCameraMove: (cameraPosition) {
            // cameraPosition.target = LatLng central del mapa
            mapaBloc.add(OnMovioMapa(cameraPosition.target)); // centroMapa
          },
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
