import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;

enum SearchType {
  location,
  service;
}

extension HintText on SearchType {
  String hintText() {
    switch (this) {
      case SearchType.location:
        return 'Adresse';
      case SearchType.service:
        return 'Diensleistung';

      default:
        if (kDebugMode) {
          print('No HintText set for SearchType! $this. Using default.');
        }
        return 'Suche';
    }
  }
}

class SearchPopup extends SearchDelegate {
  final SearchType searchType;
  final String hintText;

  final List<String> _dummySearchList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7'
  ];

  SearchPopup({required this.searchType, required this.hintText})
      : super(searchFieldLabel: hintText);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
      if (searchType == SearchType.location)
        IconButton(
          onPressed: () async {
            final location =
                await osm.showSimplePickerLocation(context: context);
            if (location != null) {
              if (kDebugMode) {
                print('location not null: $location');
                print('location: ${location.latitude}, ${location.longitude}');
                print('Close due to picked location...');
              }
              close(context, location);
            }
          },
          icon: const Icon(
            Icons.map,
          ),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions =
        _dummySearchList.where((element) => element.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestions[index]),
        onTap: () {
          switch (searchType) {
            case SearchType.location:
              close(context, osm.GeoPoint(latitude: 123123, longitude: 12314));
              break;
            case SearchType.service:
              close(context, suggestions[index]);
              break;
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        _dummySearchList.where((element) => element.contains(query)).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestions[index]),
        onTap: () {
          switch (searchType) {
            case SearchType.location:
              close(
                  context, osm.GeoPoint(latitude: 12.3123, longitude: 12.314));
              break;
            case SearchType.service:
              close(context, suggestions[index]);
              break;
          }
        },
      ),
    );
  }
}
