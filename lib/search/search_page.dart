import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/search/search_finals.dart';
import 'package:autoroutetest/search/search_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class SearchObject {}

class SearchPage extends StatefulWidget {
  String? query;
  int? postalCode;
  String? datestart, dateend;
  String? pricemax, pricemin;

  SearchPage({
    @QueryParam(SearchFinals.query) this.query,
    @QueryParam(SearchFinals.postalCode) int? postalCode,
    @QueryParam(SearchFinals.datestart) this.datestart,
    @QueryParam(SearchFinals.dateend) this.dateend,
    @QueryParam(SearchFinals.pricemax) this.pricemax,
    @QueryParam(SearchFinals.pricemin) this.pricemin,
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late MapController _mapController;
  late OverlayEntry _popupDialog;

  @override
  void initState() {
    super.initState();
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
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
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
            IconButton(
              onPressed: () async {
                //Overlay.of(context)!.insert(_popupDialog);
                context.router.push(
                  const MapRouter(),
                );
              },
              icon: const Icon(
                Icons.map,
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Searchquery: ',
              ),
              Text(
                'contains ?: }',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
