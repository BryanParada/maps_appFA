


import 'package:flutter/material.dart';
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
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
      ],
    );
  }



}