import 'package:flutter/material.dart';
import 'package:mapear/models/search_result.dart';

class DestinoSearchDelegate extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  DestinoSearchDelegate() : searchFieldLabel = 'Buscar';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, SearchResult(cancelo: true)),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text(
      'buildresults',
      style: TextStyle(color: Colors.black),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Colocar Ubicación Manualmente'),
            onTap: () {
              close(context, SearchResult(cancelo: false, manual: true));
            })
      ],
    );
  }
}
