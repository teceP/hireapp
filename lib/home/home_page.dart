import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/commons/paging_scroll_physics.dart';
import 'package:autoroutetest/commons/scrolling_behavior.dart';
import 'package:autoroutetest/home/home_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/search/home_query_cubit.dart';
import 'package:autoroutetest/search/query_cubit.dart';
import 'package:autoroutetest/search/query_model.dart';
import 'package:autoroutetest/search/search_popup.dart';
import 'package:autoroutetest/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _tabBarViewHeight = 315.0;

  final _scrollController = ScrollController();
  bool _isScrolledToTop = true;
  static const double emptySpace = 10.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        if (!_isScrolledToTop) {
          setState(() {
            _isScrolledToTop = true;
          });
        }
      } else {
        if (_scrollController.offset > emptySpace && _isScrolledToTop) {
          setState(() {
            _isScrolledToTop = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppFinals.animationDuration,
      child: Scaffold(
        appBar: AppBar(
          elevation: _isScrolledToTop ? 0 : 2,
          backgroundColor: Colors.grey[50],
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.blur_on,
                color: AppFinals.primaryColor,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                padding: EdgeInsets.zero,
                icon: LayoutBuilder(
                  builder: (context, constraints) => Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: constraints.biggest.width,
                        height: constraints.biggest.height,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppFinals.primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        width: constraints.biggest.width * 0.97,
                        height: constraints.biggest.height * 0.97,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          // color: AppFinals.primaryColorDark,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/dummy/person/Mario.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            //top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*_buildHeader(context),
              const SizedBox(
                height: 20,
              ),*/
              _buildWelcome(),
              const SizedBox(
                height: 20,
              ),
              _01_buildSearch(context),
              const SizedBox(
                height: 20,
              ),
              /*_x_buildText(context, 'Finde die besten Angebote'),
              const SizedBox(
                height: 10,
              ),*/
              _2_buildTab(context),
              const SizedBox(
                height: 10,
              ),
              _x_buildText(context, 'Deine Suche fortsetzen'),
              const SizedBox(
                height: 10,
              ),
              for (final w in _buildLatestSearches2(context)) w,
              //_3_buildLatestSearches(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.blur_on,
          color: AppFinals.primaryColor,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        padding: EdgeInsets.zero,
        icon: LayoutBuilder(
          builder: (context, constraints) => Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: constraints.biggest.width,
                height: constraints.biggest.height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppFinals.primaryColor,
                  ),
                ),
              ),
              Container(
                width: constraints.biggest.width * 0.97,
                height: constraints.biggest.height * 0.97,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  // color: AppFinals.primaryColorDark,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/dummy/person/Mario.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final double _homePagePadding = 32;

  Widget _buildWelcome() => ListTile(
        contentPadding: EdgeInsets.only(
          left: _homePagePadding,
          right: MediaQuery.of(context).size.width * 0.15,
        ),
        title: Text(
          'Welcome to your greenhouse',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: AppFinals.primaryColorDark,
              ),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget _x_buildText(BuildContext context, String text) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _homePagePadding, //AppFinals.horizontalPadding,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            color: AppFinals.primaryColorDark,
          ),
        ),
      );

  Widget _01_buildSearch(BuildContext context) =>
      BlocBuilder<HomeQueryCubit, QueryModel>(
        builder: (context, homeQueryState) => Padding(
          padding: EdgeInsets.symmetric(horizontal: _homePagePadding),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
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
            child: __buildWhatDoYouSearch(),
            /*Column(
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
                          context
                              .read<HomeQueryCubit>()
                              .updateQuery(searchResult);
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

                          //... do something with result.
                          context
                              .read<HomeQueryCubit>()
                              .updateQuery(searchResult);
                        }
                      }),
                      child: Text((context
                              .watch<HomeQueryCubit>()
                              .state
                              .query
                              .isNotEmpty)
                          ? context.watch<HomeQueryCubit>().state.query
                          : 'Wonach suchst du?'),
                    ),
                    trailing: null,
                  ),
                ),

                /**
               * Address...
               */
                /*const Divider(
                  color: Colors.black26,
                  height: 2,
                ),*/
                /*
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
                          context.read<HomeQueryCubit>().updateLatLon(
                              geoPointResult.latitude,
                              geoPointResult.longitude);

                          print('Resoluting...');
                          final res = await Nominatim.reverseSearch(
                              lat: geoPointResult.latitude,
                              lon: geoPointResult.longitude);
                          print('finished: ${res.address}');
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
                          context.read<HomeQueryCubit>().updateLatLon(
                              geoPointResult.latitude,
                              geoPointResult.longitude);
                        }
                      }),
                      child: FutureBuilder<Place>(
                        future: Utils.reverseLatLong(
                            context.read<HomeQueryCubit>().state.lat,
                            context.read<HomeQueryCubit>().state.lon),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            final data = snapshot.data!;
                            final textAddress =
                                '${Utils.buildAddressText(data)}';
                            final textDistance =
                                '${context.read<HomeQueryCubit>().state.distance} km Umkreis';
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAddress,
                                ),
                                /*Text(
                                  textDistance,
                                ),*/
                              ],
                            );
                          } else {
                            return Text(
                                '${context.read<HomeQueryCubit>().state.lat}, ${context.read<HomeQueryCubit>().state.lon} - ${context.read<HomeQueryCubit>().state.distance} km Umkreis');
                          }
                        },
                      ),
                    ),
                    trailing:
                        null, /*GestureDetector(
                      onTap: showDistanceDialog,
                      child: const Icon(
                        FontAwesomeIcons.airbnb,
                      ),
                    ),*/
                  ),
                ),*/
                const Divider(
                  color: Colors.black26,
                  height: 2,
                ),
                /**
               * DateTime...
               */
                /*InkWell(
                  onTap: showDateDialog,
                  child: ListTile(
                    minLeadingWidth: 10,
                    leading: const Icon(Icons.calendar_month),
                    title: GestureDetector(
                      child: Text(
                        Utils.formatDate(
                          DateTime.fromMillisecondsSinceEpoch(context
                              .watch<HomeQueryCubit>()
                              .state
                              .dateInMillis),
                        ),
                      ),
                    ),
                    /*Text("Mi. 14 Dez. - So. 18 Dez."),*/
                    trailing: null,
                  ),
                ),*/
                ElevatedButton(
                  onPressed: () {
                    final homeQueryModel = context.read<HomeQueryCubit>().state;
                    final id = context
                        .read<QueryCubit>()
                        .addQueryModel(homeQueryState);

                    if (id == -2) {
                      print('ERROR ALERT: ID of Query is -2!');
                    } else {
                      context.read<HomeQueryCubit>().backToDefault();
                    }

                    context.router.push(
                      SearchRouter(
                        id: id,
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
            ),*/
          ),
        ),
      );

  /*void showDateDialog() async {
    final homeQueryState = context.read<HomeQueryCubit>().state;

    final lastDate = DateTime.now().add(
      const Duration(
        days: 365,
      ),
    );
    final chosenDate = await showDialog<DateTime?>(
      context: context,
      builder: (context) => DatePickerDialog(
          initialDate:
              DateTime.fromMillisecondsSinceEpoch(homeQueryState.dateInMillis),
          firstDate: DateTime.now(),
          lastDate: lastDate),
    );

    if (chosenDate != null) {
      print('Chosen Date: $chosenDate');
      context
          .read<HomeQueryCubit>()
          .updateDateInMillis(chosenDate.millisecondsSinceEpoch);
    }
  }*/

  Widget __buildWhatDoYouSearch() => BlocBuilder<HomeQueryCubit, QueryModel>(
        builder: (context, homeQueryState) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppFinals.thirdColor,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 16),
            minVerticalPadding: 0,
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

                  //... do something with result.
                  context.read<HomeQueryCubit>().updateQuery(searchResult);
                }
              }),
              child: Text(
                (context.watch<HomeQueryCubit>().state.query.isNotEmpty)
                    ? context.watch<HomeQueryCubit>().state.query
                    : 'Wonach suchst du?',
                style: TextStyle(
                  color: AppFinals.primaryColorDark,
                ),
              ),
            ),
            trailing: LayoutBuilder(
              builder: (context, constraints) => GestureDetector(
                onTap: (() {
                  final homeQueryModel = context.read<HomeQueryCubit>().state;
                  final id =
                      context.read<QueryCubit>().addQueryModel(homeQueryState);

                  if (id == -2) {
                    print('ERROR ALERT: ID of Query is -2!');
                  } else {
                    context.read<HomeQueryCubit>().backToDefault();
                  }

                  context.router.push(
                    SearchRouter(
                      id: id,
                    ),
                  );
                }),
                child: Container(
                  height: constraints.biggest.height,
                  width: constraints.biggest.height,
                  decoration: BoxDecoration(
                    color: AppFinals.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

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

  List<Widget> _buildLatestSearches2(BuildContext context) {
    List<Widget> widgets = [];

    for (final current in HomeData.latestSearches) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: AppFinals.verticalPadding),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: _homePagePadding,
            ),
            decoration: BoxDecoration(
              color: AppFinals.thirdColor,
              borderRadius: BorderRadius.circular(
                AppFinals.borderRadius,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppFinals.borderRadius - 5,
                ),
                child: Image.asset(
                  current.picUri,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(
                current.destination,
                style: TextStyle(
                  color: AppFinals.primaryColorDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                '${current.date}, ${current.capacity}',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppFinals.thirdColorGreened,
                ),
              ),
              trailing: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppFinals.borderRadius,
                  ),
                  color: AppFinals.primaryColor,
                  shape: BoxShape.rectangle,
                ),
                child: AppFinals.navigageNextIconWhite,
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

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
        color: Colors.transparent,
        child: TabBar(
          padding: const EdgeInsets.symmetric(
            horizontal: AppFinals.horizontalPadding,
          ),
          labelStyle: TextStyle(
            fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: Theme.of(context).textTheme.subtitle1!.fontWeight,
            fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
          ),
          indicatorColor: Colors.transparent,
          unselectedLabelColor: AppFinals.thirdColorGreyed,
          labelColor: AppFinals.primaryColorDark,
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
