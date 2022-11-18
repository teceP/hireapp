import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/search/search_popup.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  /**
   * Parameters:
   * 
   */
  final String query;

  Map<String, String> queryMap = {};

  SearchPage({required this.query, super.key}) {
    print('query: $query');

    final plainQuery = query.replaceFirst('?', '');
    print('plainQuery: ' + plainQuery);
    //final plainQuery = Uri.decodeQueryComponent(plainQuery);

    if (plainQuery.contains('?')) {
      final params = plainQuery.split('?');
      for (final p in params) {
        print('p= $p');
      }
    }

    //print('decoded: ' + decodeddQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: const AutoLeadingButton(),
          title: const TextField(
            decoration: InputDecoration(
                hintText: 'Suche',
                fillColor: Colors.white,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPopup(),
                );
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Searchquery: $query',
              ),
              Text(
                'contains ?: ${query.contains('?')}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
