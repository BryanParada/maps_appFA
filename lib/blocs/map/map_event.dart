part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent{
  final GoogleMapController controller;
  OnMapInitializedEvent(this.controller); //<-- parametro posicional 
}

class OnStopFollowingUserMapEvent extends MapEvent{}
class OnStartFollowingUserMapEvent extends MapEvent{}

class UpdateUserPolylineEvent extends MapEvent{
  final List<LatLng> userLocations;
  UpdateUserPolylineEvent(this.userLocations);
}

class OnToggleUserRoute extends MapEvent{}
