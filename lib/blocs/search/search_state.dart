part of 'search_bloc.dart';

 class SearchState extends Equatable {

  final bool displayManualMarker;
  final List<Feature> places; //features segun mapbox

  const SearchState({
     this.displayManualMarker = false,
     this.places = const []
    });
  
  SearchState copyWith({
    bool? displayManualMarker,
    List<Feature>? places,
  }) => SearchState(
    displayManualMarker:  displayManualMarker ?? this.displayManualMarker,
    places:  places ?? this.places,
  );



  @override
  List<Object> get props => [displayManualMarker, places]; //para que equatable sea capaz de decirle a bloc que hay nuevas propiedades
}
 