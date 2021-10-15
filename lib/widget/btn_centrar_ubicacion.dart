part of 'widget_imports.dart';

class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final miUbicacion = BlocProvider.of<MiUbicacionBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: context.height * 0.015),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: context.height * 0.025,
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              mapaBloc.moverCamara(miUbicacion.state.ubicacion);
            },
            icon: const Icon(Icons.my_location, color: Colors.black87)),
      ),
    );
  }
}
