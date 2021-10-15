part of 'widget_imports.dart';

class BtnOcultarPolyline extends StatelessWidget {
  const BtnOcultarPolyline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: context.height * 0.015),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: context.height * 0.025,
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              mapaBloc.add(OnMarcarRecorrido());
            },
            icon: const Icon(Icons.more_horiz, color: Colors.black87)),
      ),
    );
  }
}
