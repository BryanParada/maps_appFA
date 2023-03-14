

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


//  const accesToken = 'apikeystring';
 String accesToken = dotenv.env['APIKEY'].toString();

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
   
   options.queryParameters.addAll({
    'alternatives': true,
    'geometries': 'polyline6',
    'language': 'en',
    'overview': 'simplified',
    'steps': false,
    'access_token': accesToken

   });



    super.onRequest(options, handler);
  }
}