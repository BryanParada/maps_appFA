import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart'; 
import 'package:maps_app/screens/screens.dart';
import 'package:maps_app/services/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async{
  await dotenv.load();

  //*se utiliza appState para obligar a que sea lo primero que se inicialice
   runApp( MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(create: (context) => MapBloc( locationBloc: BlocProvider.of<LocationBloc>(context)  )),
      BlocProvider(create: (context) => SearchBloc( trafficService: TrafficService() )),
    ],
    child: MapsApp(),
     ));

}
 

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      // home: TestMarkerScreen(),
      home: LoadingScreen(),
    );
  }
}