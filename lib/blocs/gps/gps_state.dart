part of 'gps_bloc.dart';

class GpsState extends Equatable {

  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted});
  
  @override
  List<Object> get props => [ isGpsEnabled, isGpsPermissionGranted]; //nos permite trabajar con equatable

  @override
  String toString() => '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted}';
  
}



// class GpsInitial extends GpsState {}
