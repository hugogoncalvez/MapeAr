part of 'widget_imports.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  const BtnSeguirUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (_, state) {
        return Container(
          margin: EdgeInsets.only(bottom: context.height * 0.015),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: context.height * 0.025,
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  mapaBloc.add(OnSeguirUbicacion());
                },
                icon: mapaBloc.state.seguirUbicacion
                    ? const Icon(Icons.directions_run, color: Colors.black87)
                    : const Icon(Icons.accessibility_new,
                        color: Colors.black87)),
          ),
        );
      },
    );
  }
}
