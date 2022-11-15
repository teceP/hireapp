import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/commons/paging_scroll_physics.dart';
import 'package:autoroutetest/commons/scrolling_behavior.dart';
import 'package:autoroutetest/home/home_data.dart';
import 'package:autoroutetest/search/home_search.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _tabBarViewHeight = 315.0;

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
  Widget _0_buildSearch(BuildContext context) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppFinals.horizontalPadding),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: AppFinals.elevation,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromARGB(255, 255, 152, 49),
              width: 2.0,
              strokeAlign: StrokeAlign.center,
            ),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Column(
            children: [
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
                    onTap: (() {
                      showSearch(context: context, delegate: HomeSearch());
                    }),
                    child: HomeData.searchObjects[0].leading,
                  ),
                  title: Hero(
                    tag: 'searchBar',
                    child: GestureDetector(
                      onTap: (() {
                        showSearch(context: context, delegate: HomeSearch());
                      }),
                      child: HomeData.searchObjects[0].title,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      print('micro:)');
                    },
                    child: HomeData.searchObjects[0].trailing,
                  ),
                ),
              ),
              const Divider(
                color: Colors.black26,
                height: 2,
              ),
              InkWell(
                onTap: (() {}),
                child: ListTile(
                  minLeadingWidth: 10,
                  leading: HomeData.searchObjects[1].leading,
                  title: HomeData.searchObjects[1].title,
                  trailing: HomeData.searchObjects[1].trailing,
                ),
              ),
              const Divider(
                color: Colors.black26,
                height: 2,
              ),
              InkWell(
                onTap: (() {}),
                child: ListTile(
                  minLeadingWidth: 10,
                  leading: HomeData.searchObjects[2].leading,
                  title: HomeData.searchObjects[2].title,
                  trailing: HomeData.searchObjects[2].trailing,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),

                  backgroundColor: Colors.blue[800],
                  minimumSize: Size.zero, // Set this
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 20), // and this
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Suchen',
                    ),
                  ),
                ),
              ),
            ],
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
              itemDimension: 30 + MediaQuery.of(context).size.width * 0.8,
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
