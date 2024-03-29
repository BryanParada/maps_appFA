import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) { // puede ser const ya que es el estado cuando se inicia

    on<OnMapInitializedEvent>(_onInitMap);
    // on<OnStartFollowingUserMapEvent>((event, emit) => emit( state.copyWith( isFollowingUser: true))); 
    //ó
    on<OnStartFollowingUserMapEvent>( _onStartFollowingUser ); 
    on<OnStopFollowingUserMapEvent>((event, emit) => emit( state.copyWith( isFollowingUser: false))); 
    on<OnToggleUserRoute>((event, emit) => emit( state.copyWith( showMyRoute: !state.showMyRoute)));
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<DisplayPolylinesEvent>( (event, emit) => emit(state.copyWith(polylines: event.polylines, markers: event.markers))); //crea nuevo estado

    locationStateSubscription = locationBloc.stream.listen( (locationState){

      if(locationState.lastKnownLocation != null){
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }

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

void _onPolylineNewPoint(UpdateUserPolylineEvent event, Emitter<MapState> emit){

    // Se crea un objeto Polyline con los datos del nuevo tramo
    final myRoute = Polyline(
      polylineId: PolylineId('myRoute'),  // Identificador único de la polilínea
      color: Colors.black,                // Color de la polilínea
      width: 5,                           // Ancho de la polilínea
      startCap: Cap.roundCap,             // Estilo de la capa de inicio
      endCap: Cap.roundCap,               // Estilo de la capa final
      points: event.userLocations         // Lista de puntos que conforman la polilínea
    );

    // Se crea una copia del mapa de polilíneas actual
    final currentPolylines = Map<String, Polyline>.from( state.polylines );

    // Se actualiza el mapa de polilíneas con la nueva polilínea
    currentPolylines['myRoute'] = myRoute;

    // Se emite el nuevo estado del mapa con la polilínea actualizada
    emit(
      state.copyWith(                    // Se crea una nueva instancia de MapState con la polilínea actualizada
        polylines: currentPolylines       // Se actualiza el mapa de polilíneas en el nuevo estado
      )
    );
}

Future  drawRoutePolyline( RouteDestination destination )async{

  final myRoute = Polyline(
    polylineId: const PolylineId('route'),
    color: Colors.black,
    width: 5,
    points: destination.points,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap
    );

    double kms = destination.distance / 1000;
    //redondear
    kms = (kms * 100).floorToDouble();
    kms /= 100; //ó kms = kms / 100

    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    //Custom Markers
    // final startMarkerIcon = await getAssetImageMarker();
    // final endMarkerIcon   = await getNetworkImageMarker();

    final startMarkerIcon = await getStartCustomMarker( tripDuration, 'My location');
    final endMarkerIcon   = await getEndCustomMarker( kms.toInt(), destination.endPlace.text );

    final startMarker = Marker(
      anchor: const Offset(0.1,1),
      markerId: MarkerId('start'),
      position: destination.points.first, // ó destination.points[0]
      icon: startMarkerIcon,
      // infoWindow: InfoWindow(
      //   title: 'Start',
      //   snippet: 'Kms: $kms, duration: $tripDuration', //This is the start of my route
      // ),
    );

    final endMarker = Marker(
      markerId: MarkerId('end'),
      position: destination.points.last,
      icon: endMarkerIcon,
      // anchor: const Offset(0,0),
      // infoWindow:  InfoWindow(
      //   title: destination.endPlace.text, //'end'
      //   snippet: destination.endPlace.placeName //'This is the end of my route'
      // ),  
    );



    final currentPolylines = Map<String, Polyline>.from( state.polylines ); //crea copia, siempre se hace un nuevo estado en bloc (state.polylines no debe ser cambiado) 
    currentPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from( state.markers ); 
    //sobreescribir el marcador que tenga el id de 'start'
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

      add( DisplayPolylinesEvent(currentPolylines, currentMarkers)); //add emite evento

      // await Future.delayed( const Duration( milliseconds: 300));
      // _mapController?.showMarkerInfoWindow(const MarkerId('start'));
}

  void moveCamera( LatLng newLocation){
    final cameraUpdate = CameraUpdate.newLatLng( newLocation ); 
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel(); // "?" si tienes un valor cancelalo, si no hay valor no hay nada que cancelar
    return super.close();
  }
}
