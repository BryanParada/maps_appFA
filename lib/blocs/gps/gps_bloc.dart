import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription;


  GpsBloc() : super(const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false)) {

    on<GpsAndPermissionEvent>((event, emit) => emit( state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted
      )) 
    );

  _init();

  }

  Future<void> _init() async {

    final isEnabled = await _checkGpsStatus();
    print('isEnabled: $isEnabled');

    add(GpsAndPermissionEvent(
      isGpsEnabled: isEnabled, 
      isGpsPermissionGranted: state.isGpsPermissionGranted
      ));
    
  }

  Future<bool> _checkGpsStatus() async{

    final isEnable = await Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      // print('service status $isEnabled');
      add(GpsAndPermissionEvent(
      isGpsEnabled: isEnabled, 
      isGpsPermissionGranted: state.isGpsPermissionGranted
      ));
    });

    return isEnable;

  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel(); // "?" si tienes un valor cancelalo, si no hay valor no hay nada que cancelar
    return super.close();
  }


}
