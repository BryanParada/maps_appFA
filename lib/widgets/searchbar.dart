 
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
        ? const SizedBox()
        : FadeInDown(
          duration: const Duration(milliseconds: 300),
          child: const _SearchBarBody()
          );
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody
({super.key});

  void onSearchResults( BuildContext context, SearchResult result){
    
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    if ( result.manual == true){
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        //color: Colors.red,
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            // print('ontap');
            final result = await showSearch(context: context, delegate: SearchDestinationDelegate());

            if (result == null) return;

            // print(result.manual);
            onSearchResults(context, result);


          },
          child: Container(
            padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 13),
            child: const Text('Where do you want to go?', style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5)
                )
              ]
            )
          ),
          )
      ),
    );
  }
}