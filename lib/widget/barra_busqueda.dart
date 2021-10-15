part of 'widget_imports.dart';

class BarraBusqueda extends StatelessWidget {
  const BarraBusqueda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (_, state) {
        if (state.seleccionManual) {
          return Container();
        }
        return FadeInDown(
            duration: const Duration(milliseconds: 400),
            child: const _BarraBusqueda());
      },
    );
  }
}

class _BarraBusqueda extends StatelessWidget {
  const _BarraBusqueda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.015),
      padding: EdgeInsets.symmetric(horizontal: context.height * 0.05),
      width: double.infinity,
      child: GestureDetector(
        onTap: () async {
          final resultado = await showSearch(
              context: context, delegate: DestinoSearchDelegate());
          retornoBusqueda(context, resultado as SearchResult);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: context.height * 0.015),
          width: double.infinity,
          height: context.height * 0.05,
          child: const Text(
            'Dónde quieres ir !',
            style: TextStyle(color: Colors.black87),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.height * 0.03),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 5),
                  blurRadius: 5,
                )
              ]),
        ),
      ),
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result) {
    print(result.cancelo);
    print(result.manual);
    if (result.cancelo) {
      return;
    } else if (result.manual) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
  }
}
