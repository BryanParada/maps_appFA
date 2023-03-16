part of 'search_bloc.dart';

 class SearchState extends Equatable {

  final bool displayManualMarker;
  final List<Feature> places; //features segun mapbox
  final List<Feature> history;

  const SearchState({
     this.displayManualMarker = false,
     this.places = const [],
     this.history = const [],
    });
  
  SearchState copyWith({
    bool? displayManualMarker,
    List<Feature>? places,
    List<Feature>? history
  }) => SearchState(
    displayManualMarker:  displayManualMarker ?? this.displayManualMarker,
    places:  places ?? this.places,
    history: history ?? this.history
  );



  @override
  List<Object> get props => [displayManualMarker, places, history]; //para que equatable sea capaz de decirle a bloc que hay nuevas propiedades
}
 