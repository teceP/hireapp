import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/commons/paging_scroll_physics.dart';
import 'package:autoroutetest/commons/scrolling_behavior.dart';
import 'package:autoroutetest/home/home_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/search/search_cubit.dart';
import 'package:autoroutetest/search/search_model.dart';
import 'package:autoroutetest/search/search_popup.dart';
import 'package:autoroutetest/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _tabBarViewHeight = 315.0;
  final SearchModel _searchModel = SearchModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _0_buildSearch(context),
          const SizedBox(
            height: 20,
          ),
          _x_buildText(context, 'Finde die besten Angebote'),
          const SizedBox(
            height: 10,
          ),
          _2_buildTab(context),
          const SizedBox(
            height: 10,
          ),
          _x_buildText(context, 'Ihre Suche fortsetzen'),
          const SizedBox(
            height: 10,
          ),
          _3_buildLatestSearches(context),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _x_buildText(BuildContext context, String text) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppFinals.horizontalPadding),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget _0_buildSearch(BuildContext context) =>
      BlocBuilder<SearchCubit, SearchModel>(
        builder: (context, state) {
          print('bloc rebuilt');
          final searchState = state;
          print('query by cubit: ${searchState.query}');
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppFinals.horizontalPadding),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: AppFinals.elevation,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: AppFinals.frameColor,
                  width: 2.0,
                  strokeAlign: StrokeAlign.center,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Column(
                children: [
                  /**
               * Service...
               */
                  InkWell(
                    onTap: (() {}),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(
                        10,
                      ),
                    ),
                    child: ListTile(
                      minLeadingWidth: 10,
                      leading: GestureDetector(
                        onTap: (() async {
                          final searchResult = await showSearch(
                            context: context,
                            delegate: SearchPopup(
                              searchType: SearchType.service,
                              hintText: SearchType.service.hintText(),
                            ),
                          );

                          if (searchResult != null) {
                            if (kDebugMode) {
                              print('Service SearchResult: $searchResult');
                            }
                            //... do something with result.
                            //searchState.query = searchResult;
                            print('saved2');
                            context.read<SearchCubit>().setQuery(searchResult);
                          }
                        }),
                        child: const Icon(Icons.search),
                      ),
                      title: GestureDetector(
                        onTap: (() async {
                          final searchResult = await showSearch(
                            context: context,
                            delegate: SearchPopup(
                              searchType: SearchType.service,
                              hintText: SearchType.service.hintText(),
                            ),
                          );

                          if (searchResult != null) {
                            if (kDebugMode) {
                              print('Service SearchResult: $searchResult');
                            }

                            print('saved');
                            //... do something with result.
                            context.read<SearchCubit>().setQuery(searchResult);
                          }
                        }),
                        child: Text(context.watch<SearchCubit>().state.query),
                      ),
                      trailing: null,
                    ),
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 2,
                  ),
                  /**
               * Address...
               */
                  InkWell(
                    onTap: (() {}),
                    child: ListTile(
                      minLeadingWidth: 10,
                      leading: GestureDetector(
                        onTap: (() async {
                          final addressSearchResult = await showSearch(
                            context: context,
                            delegate: SearchPopup(
                              searchType: SearchType.location,
                              hintText: SearchType.location.hintText(),
                            ),
                          );

                          if (addressSearchResult != null) {
                            final osm.GeoPoint geoPointResult =
                                addressSearchResult;

                            if (kDebugMode) {
                              print('Location SearchResult: $geoPointResult');
                            }
                            //... do something with result.
                            setState(() {
                              _searchModel.addressLatLong = geoPointResult;
                              //temporary...
                              if (kDebugMode) {
                                print(
                                    'set address temporarly to lat lon. should convert lat lon to address string here later.');
                              }
                              _searchModel.address =
                                  '${geoPointResult.latitude}, ${geoPointResult.longitude}';
                            });
                          }
                        }),
                        child: HomeData.searchObjects[2].leading,
                      ),
                      title: GestureDetector(
                        onTap: (() async {
                          final addressSearchResult = await showSearch(
                            context: context,
                            delegate: SearchPopup(
                              searchType: SearchType.location,
                              hintText: SearchType.location.hintText(),
                            ),
                          );

                          if (addressSearchResult != null) {
                            final osm.GeoPoint geoPointResult =
                                addressSearchResult;
                            if (kDebugMode) {
                              print('Location SearchResult: $geoPointResult');
                            }
                            //... do something with result.
                            setState(() {
                              _searchModel.addressLatLong = geoPointResult;

                              //temporary...
                              if (kDebugMode) {
                                print(
                                    'set address temporarly to lat lon. should convert lat lon to address string here later.');
                              }
                              _searchModel.address =
                                  '${geoPointResult.latitude}, ${geoPointResult.longitude}';
                            });
                          }
                        }),
                        child: Text(
                            '${_searchModel.address} - ${_searchModel.distance} km Umkreis'), //HomeData.searchObjects[2].title,
                      ),
                      trailing: GestureDetector(
                        onTap: showDistanceDialog,
                        child: const Icon(
                          FontAwesomeIcons.airbnb,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 2,
                  ),
                  /**
               * DateTime...
               */
                  InkWell(
                    onTap: showDateDialog,
                    child: ListTile(
                      minLeadingWidth: 10,
                      leading: const Icon(Icons.calendar_month),
                      title: GestureDetector(
                        child: Text(
                          Utils.formatDate(_searchModel.dateTime),
                        ),
                      ),
                      /*Text("Mi. 14 Dez. - So. 18 Dez."),*/
                      trailing: null,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.router.push(
                        SearchRouter(
                          service: _searchModel.query,
                          distance: _searchModel.distance,
                          dateAsInt:
                              _searchModel.dateTime.millisecondsSinceEpoch,
                          latitude: _searchModel.addressLatLong.latitude,
                          longitude: _searchModel.addressLatLong.longitude,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      backgroundColor: AppFinals.buttonColor,
                      minimumSize: Size.zero, // Set this
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20), // and this
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Suchen',
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: AppFinals.textSizeButton,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  void updateView(int distance) {}

  void showDistanceDialog() async {
    final int originDistance = _searchModel.distance;
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Maximaler Umkreis ${_searchModel.distance} km'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: AppFinals.horizontalPadding,
                  ),
                  const Text('1'),
                  Expanded(
                    child: Slider(
                      min: 1,
                      max: 25,
                      value: _searchModel.distance.toDouble(),
                      onChanged: (value) => setState(
                        () => _searchModel.distance = value.toInt(),
                      ),
                    ),
                  ),
                  const Text('25'),
                  const SizedBox(
                    width: AppFinals.horizontalPadding,
                  ),
                ],
              ),
              const SizedBox(
                height: AppFinals.commonWidgetDistance,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _searchModel.distance = originDistance;
                      context.router.pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100),
                    child: const Text(
                      'Abbrechen',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: AppFinals.commonButtonDistance,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    child: const Text('OK '),
                  ),
                  const SizedBox(
                    width: AppFinals.horizontalPadding,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    setState(() {
      //so distance gets refreshed
    });
  }

  void showDateDialog() async {
    final lastDate = DateTime.now().add(
      const Duration(
        days: 365,
      ),
    );
    final chosenDate = await showDialog<DateTime?>(
      context: context,
      builder: (context) => DatePickerDialog(
          initialDate: _searchModel.dateTime,
          firstDate: DateTime.now(),
          lastDate: lastDate),
    );

    if (chosenDate != null) {
      print('Chosen Date: $chosenDate');
      setState(() {
        _searchModel.dateTime = chosenDate;
      });
    }
  }

  // ignore: non_constant_identifier_names
  Widget _2_buildTab(BuildContext context) => DefaultTabController(
        length: HomeData.getTabTupe(_tabBarViewHeight).length,
        initialIndex: 0,
        child: SizedBox(
          height: _tabBarViewHeight + AppBar().preferredSize.height,
          width: double.infinity,
          child: Scaffold(
            body: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: HomePageTabBarSliverPersistentHeaderDelegate(
                    tabs: HomeData.getTabTupe(_tabBarViewHeight)
                        .map((t) => t.tab)
                        .toList(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: _tabBarViewHeight,
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ...HomeData.getTabTupe(_tabBarViewHeight)
                            .map((t) => t.page),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget _3_buildLatestSearches(BuildContext context) => SizedBox(
        height: 210,
        width: double.infinity,
        child: ScrollConfiguration(
          behavior: ScrollingBehavior(),
          child: GridView.builder(
            padding: const EdgeInsets.only(
              left: AppFinals.horizontalPadding,
              right: AppFinals.horizontalPadding,
              bottom: 5,
            ),
            physics: PagingScrollPhysics(
              parent: const BouncingScrollPhysics(),
              itemDimension: MediaQuery.of(context).size.width * 0.83,
            ),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: HomeData.latestSearches.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.3,
              crossAxisCount: 2,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) =>
                HomeData.latestSearches[index].buildWidget(),
          ),
        ),
      );
}

class HomePageTabBarSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final List<Widget> tabs;

  HomePageTabBarSliverPersistentHeaderDelegate({required this.tabs});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.topLeft,
      child: ColoredBox(
        color: Colors.grey[50]!,
        child: TabBar(
          padding: const EdgeInsets.symmetric(
              horizontal: AppFinals.horizontalPadding),
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          physics: const BouncingScrollPhysics(),
          automaticIndicatorColorAdjustment: false,
          isScrollable: true,
          tabs: [...tabs],
        ),
      ),
    );
  }

  @override
  double get maxExtent => AppBar().preferredSize.height;

  @override
  double get minExtent => AppBar().preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
