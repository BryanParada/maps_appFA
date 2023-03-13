import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  TrafficService trafficService;

  SearchBloc({
    required this.trafficService
  }) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>((event, emit)  => emit( state.copyWith(displayManualMarker: true) ) ) ;
    on<OnDeactivateManualMarkerEvent>((event, emit)  => emit( state.copyWith(displayManualMarker: false) ) ) ;
  }
}
