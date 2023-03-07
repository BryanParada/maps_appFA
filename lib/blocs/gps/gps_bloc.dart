import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
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
    
  }

  Future<bool> _checkGpsStatus() async{

    final isEnable = await Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      print('service status $isEnabled');
    });

    return isEnable;

  }

  @override
  Future<void> close() {
    //TODO: limpiar el servicestatus stream
    return super.close();
  }


}
