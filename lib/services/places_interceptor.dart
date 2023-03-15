

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
 


class PlacesInterceptor extends Interceptor {

 String accesToken = dotenv.env['APIKEY'].toString();
 
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {


       
   options.queryParameters.addAll({ 
     'access_token': accesToken,
     'language'    : 'en',
     'limit'       : 7

   });
    
    super.onRequest(options, handler);
  }

}