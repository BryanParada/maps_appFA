

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

class TrafficService {

  //para almacenar rutas de trafico
  final Dio _dioTraffic;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';


  TrafficService()
    : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor() ); //TODO: configurar interceptors

  Future<TrafficResponse> getCoorsStartToEnd( LatLng start, LatLng end) async{

    

    final coorsString = '${start.longitude}, ${start.latitude}; ${end.longitude}, ${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromMap(resp.data); //no es necesario que sea asincrono, todo se ejecuta en el mismo hilo de tiempo
 
    return data; //resp.data
    

//     try {
//   final resp = await _dioTraffic.get(url);
//   return resp.data;
// } catch (e) {
//   if (e is DioError) {
//     if (e.response?.statusCode == 401) {
//       print('Error 401: El token de acceso no es válido');
//     }
//   }
//   // manejar otros errores aquí
// }


  }

}