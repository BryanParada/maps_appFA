import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation; 
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  const MapView({
    super.key, 
   required this.initialLocation,
   required this.polylines,
   required this.markers
  });

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 15
      );

    final size = MediaQuery.of(context).size;


    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener( //similar al gestureDetector
        onPointerMove: ( pointerMoveEvent ) => mapBloc.add( OnStopFollowingUserMapEvent() ),
        child: GoogleMap(
                initialCameraPosition: initialCameraPosition,
                // compassEnabled: true,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                markers: markers,
                polylines: polylines,
                onMapCreated: ( controller ) => mapBloc.add( OnMapInitializedEvent(controller)),
      
                //TODO: Markers
                //TODO: polylines
                onCameraMove: ( position ) => mapBloc.mapCenter = position.target , //targe = lat y long
                ),
      ),
    );
  }
}