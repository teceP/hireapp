import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/search/search_finals.dart';
import 'package:autoroutetest/search/search_popup.dart';
import 'package:autoroutetest/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/**
 * 
 * 
   String service = 'Friseur';

  String address = 'Lohmühlenstraße 40, 12435';

  osm.GeoPoint addressLatLong =
      osm.GeoPoint(latitude: 12.3456, longitude: 65.4321);

  int distance = 20;

  DateTime dateTime = DateTime.now();
 */

class SearchPage extends StatefulWidget {
  String? service;
  double? latitude, longitude;
  int? distance;
  int? dateAsInt;

  SearchPage({
    @QueryParam('service') this.service,
    @QueryParam('latitude') this.latitude,
    @QueryParam('longitude') this.longitude,
    @QueryParam('distance') this.distance,
    @QueryParam('dateAsInt') this.dateAsInt,
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
          title: TextField(
            decoration: InputDecoration(
              hintText: widget.service ?? 'Suche',
              fillColor: Colors.white,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              print(value);
              widget.service = value;
            },
          ),
          actions: [
            /*IconButton(
              onPressed: () {
                //Another showSearch, when user is already in "active searching", after clicked on "Suchen"
                //-- not needed, since user can tap on editTextfield
                showSearch(
                  context: context,
                  delegate: SearchPopup(
                    searchType: SearchType.service,
                    hintText: SearchType.service.hintText(),
                  ),
                );
              },
              icon: const Icon(
                Icons.search,
              ),
            ),*/
            IconButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Filter'),
                        leading: const AutoLeadingButton(),
                      ),
                      body: SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: AppFinals.horizontalPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildDate(),
                                  const SizedBox(
                                    width: AppFinals.verticalPadding,
                                  ),
                                  _buildTime(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.filter_list,
              ),
            ),
            IconButton(
              onPressed: () async {
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
          child: _buildSuggestions(),
        ),
      ),
    );
  }

  Widget _buildDate() {
    DateTime now = DateTime.now();
    DateTime currentChosenDate = DateTime.fromMillisecondsSinceEpoch(
        widget.dateAsInt ?? now.millisecondsSinceEpoch);

    final lastDate = now.add(
      const Duration(
        days: 365,
      ),
    );

    return TextButton(
      onPressed: () => showDatePicker(
        context: context,
        initialDate: currentChosenDate,
        firstDate: now,
        lastDate: lastDate,
      ),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.calendar,
            size: AppFinals.iconInTextSize,
          ),
          const SizedBox(
            width: AppFinals.paddingInText,
          ),
          Text(
            'Datum: ${Utils.formatDate(currentChosenDate)}',
          ),
        ],
      ),
    );
  }

  Widget _buildTime() {
    final DateTime currentChosenDate =
        DateTime.fromMillisecondsSinceEpoch(widget.dateAsInt!);

    final bool isChosenDateToday = Utils.isDateToday(currentChosenDate);
    final bool isChosenDateZeroTime =
        Utils.isChosenDateZeroTime(currentChosenDate);

    final bool shouldBeAnyTime = !isChosenDateToday && isChosenDateZeroTime;

    String text;
    if (shouldBeAnyTime) {
      text = 'Uhrzeit: Ganzer Tag';
    } else {
      text = 'Uhrzeit: ${Utils.formatTime(currentChosenDate)}';
    }

    return TextButton(
        onPressed: () async {
          TimeOfDay? chosenTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (chosenTime != null) {
            print('choosed timeofday $chosenTime');

            final DateTime originChosen =
                DateTime.fromMillisecondsSinceEpoch(widget.dateAsInt!);
            final DateTime newChosen = DateTime(
              originChosen.year,
              originChosen.month,
              originChosen.day,
              chosenTime.hour,
              chosenTime.minute,
            );

            setState(() {
              widget.dateAsInt = newChosen.millisecondsSinceEpoch;
            });
          }
        },
        child: Row(
          children: [
            const Icon(
              FontAwesomeIcons.clock,
              size: AppFinals.iconInTextSize,
            ),
            const SizedBox(
              width: AppFinals.paddingInText,
            ),
            Text(
              text,
            ),
          ],
        ));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppFinals.horizontalPaddingLess,
      ),
      itemCount: TabBarData.animals.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            top: 10,
            bottom: (index == (TabBarData.animals.length - 1)) ? 10 : 0),
        child: PreviewCard(
          item: TabBarData.animals[index],
          shopId: '54321',
          height: Utils.h(context) * 0.3,
          tabBarDataIndex: index,
        ),
      ),
    );
  }
}
