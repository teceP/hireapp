import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/search/home_search.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: const Hero(
          tag: 'searchBar',
          child: TextField(
            decoration:
                InputDecoration(hintText: 'Suche', fillColor: Colors.white, enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: HomeSearch(),
              );
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: const [
            Text(
              'Search',
            ),
          ],
        ),
      ),
    );
  }
}
