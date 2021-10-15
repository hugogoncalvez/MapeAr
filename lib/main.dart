import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapear/bloc/busqueda/busqueda_bloc.dart';
import 'package:mapear/bloc/mapa/mapa_bloc.dart';
import 'package:mapear/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapear/pages/acceso_gps_page.dart';
import 'package:mapear/pages/loading_page.dart';
import 'package:mapear/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MiUbicacionBloc()),
        BlocProvider(create: (_) => MapaBloc()),
        BlocProvider(create: (_) => BusquedaBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LoadingPage(),
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'acceso_gps': (_) => AccesoGpsPage()
        },
      ),
    );
  }
}
