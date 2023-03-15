

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


//  const accesToken = 'apikeystring';

class TrafficInterceptor extends Interceptor {

 String accesToken = dotenv.env['APIKEY'].toString();
 
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