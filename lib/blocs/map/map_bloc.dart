import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  MapBloc() : super(const MapState()) { // puede ser const ya que es el estado cuando se inicia

    on<MapEvent>((event, emit) {});
  }
}
