import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;

  GoogleMapController? _mapController;

  MapBloc({required this.locationBloc}) : super(const MapState()) { // puede ser const ya que es el estado cuando se inicia

    on<OnMapInitializedEvent>(_onInitMap);
    // on<OnStartFollowingUserMapEvent>((event, emit) => emit( state.copyWith( isFollowingUser: true))); 
    //ó
    on<OnStartFollowingUserMapEvent>( _onStartFollowingUser ); 
    on<OnStopFollowingUserMapEvent>((event, emit) => emit( state.copyWith( isFollowingUser: false))); 

    locationBloc.stream.listen( (locationState){

      if ( !state.isFollowingUser ) return;
      if ( locationState.lastKnownLocation == null) return;

      moveCamera( locationState.lastKnownLocation!); 

    });
  }

  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit){

    _mapController = event.controller; 

    _mapController!.setMapStyle( jsonEncode(uberMapTheme) );

    emit( state.copyWith(isMapInitialized: true));

  }

  void _onStartFollowingUser(OnStartFollowingUserMapEvent,Emitter<MapState> emit){
     

      emit( state.copyWith( isFollowingUser: true));
      if ( locationBloc.state.lastKnownLocation == null) return;
      //si ya tenemos la ubicacion del usuario entonces
      //no esperara a cambiar la siguiente coordenada, se movera el mapa inmediatamente
      moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void moveCamera( LatLng newLocation){
    final cameraUpdate = CameraUpdate.newLatLng( newLocation ); 
    _mapController?.animateCamera(cameraUpdate);
  }
}
