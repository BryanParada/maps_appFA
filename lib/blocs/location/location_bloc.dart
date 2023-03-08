import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/blocs/blocs.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription? positionStream;
  final GpsBloc _gpsBloc = GpsBloc();

  LocationBloc() : super( const LocationState()) {

     on<OnNewUserLocationEvent>((event, emit) {
          emit(state.copyWith(
            lastKnownLocation: event.newLocation,
            myLocationHistory: [ ...state.myLocationHistory, event.newLocation], //sparce todo lo de mylocationHistory y añade al final newLocation
          )
        );
    });
  }

  Future getCurrentPosition() async{
    if (!_gpsBloc.state.isAllGranted) return;
    final position = await Geolocator.getCurrentPosition();

    print('position: $position');
    add( OnNewUserLocationEvent( LatLng( position.latitude, position.longitude)));
    
  }

  void startFollowingUser(){
    if (!_gpsBloc.state.isAllGranted) return;
    print('startFollowingUser');
    
    positionStream = Geolocator.getPositionStream().listen((event) { 
      final position = event;
      print('position: $position');
      add( OnNewUserLocationEvent( LatLng( position.latitude, position.longitude)));
      
    });

  }

  void stopFollowingUser(){
    positionStream?.cancel(); // "?" si tienes un valor cancelalo, si no hay valor no hay nada que cancelar
    print('stopFollowingUser');
    
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }


}
