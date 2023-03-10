


import 'package:flutter/material.dart';

class SearchDestinationDelegate extends SearchDelegate{
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
      close(context, null);
    }
   );
     
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('buildSuggestions');
  }



}