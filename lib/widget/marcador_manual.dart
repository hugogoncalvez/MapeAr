part of 'widget_imports.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (_, state) {
        if (state.seleccionManual) {
          return const _BuildMarcadorManual();
        }
        return Container();
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  const _BuildMarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Boton regresar
        Positioned(
          top: context.height * 0.085,
          left: context.height * 0.016,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 250),
            child: CircleAvatar(
              maxRadius: context.height * 0.03,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {
                    BlocProvider.of<BusquedaBloc>(context)
                        .add(OnDesactivarMarcadorManual());
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  )),
            ),
          ),
        ),
        Center(
          child: BounceInDown(
            child: Icon(
              Icons.location_on,
              size: context.height * 0.055,
            ),
          ),
        ),
        // boton de confirmar destino
        Positioned(
          child: FadeIn(
            child: MaterialButton(
              onPressed: () => calcularDestino(context),
              minWidth: context.width * 0.77,
              child: const Text('Confirmar Destino',
                  style: TextStyle(color: Colors.white)),
              color: Colors.black87,
              shape: const StadiumBorder(),
              splashColor: Colors.transparent,
            ),
          ),
          bottom: context.height * 0.085,
          left: context.height * 0.04,
        )
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    final trafficService = TrafficService();
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = BlocProvider.of<MapaBloc>(context).state.ubicacionCentral;

    await trafficService.getCoordenadasInicioDestino(inicio, destino);
  }
}
