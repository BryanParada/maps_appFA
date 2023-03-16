


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult>{

  SearchDestinationDelegate():super(
    searchFieldLabel: 'Search...'
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
    IconButton(
     icon: const Icon(Icons.clear),
     onPressed: (){
      query = '';
     },
    )
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(
     icon: Icon(Icons.arrow_back_ios),
    onPressed: (){
      final result = SearchResult(cancel: true);
      close(context, result);
    }
   );
     
  }

  @override
  Widget buildResults(BuildContext context) {

    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnownLocation!;
    searchBloc.getPlacesByQuery( proximity, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        // return Text('Results ${ state.places.length}');
        return ListView.separated(
          itemCount: places.length,
          itemBuilder: ( context, i ) {
            final place = places[i];
            return ListTile(
              title: Text(place.text),
              subtitle: Text(place.placeName),
              leading: const Icon( Icons.place_outlined, color: Colors.black),
              onTap: () {
                final result = SearchResult(
                  cancel: false,
                   manual: false,
                   position: LatLng( place.center[1], place.center[0]),  //mapbox: lng-lat google:lat-lng
                   name: place.text,
                   description: place.placeName
                   );

                searchBloc.add(AddToHistoryEvent(place));

                close(context, result);
                // print('send this place $place');
                
              }
            );
          },
          separatorBuilder: ( context, i ) => const Divider(),
        );
      },
    );

    
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final history = BlocProvider.of<SearchBloc>(context).state.history;

    return ListView(
      children: [
        ListTile(
          leading: const Icon( Icons.location_on_outlined, color: Colors.black) ,
          title: const Text('Put manual location', style: TextStyle(color: Colors.black)), 
          onTap: (){
            //TODO: regresar algo

            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),

        //barre todos los elementos del listado y regresa otro listado
        ...history.map((place) => ListTile(
           title: Text(place.text),
              subtitle: Text(place.placeName),
              leading: const Icon( Icons.history, color: Colors.black),
              onTap: (){
                final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center[1], place.center[0]),
                  name: place.text,
                  description: place.placeName
                );

                close(context, result);
              },
        )) 
      ],
    );
  }



}