import 'package:autoroutetest/home/home_page.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/tabbar/beauty_search_page.dart';
import 'package:autoroutetest/home/tabbar/face_search_page.dart';
import 'package:autoroutetest/home/tabbar/female_search_page.dart';
import 'package:autoroutetest/home/tabbar/male_search_page.dart';
import 'package:autoroutetest/home/tabbar/massages_search_page.dart';
import 'package:autoroutetest/home/tabbar/pensioners_search_page.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/home/tabbar/tools_search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LatestSearchObject {
  final String picUri;
  final String destination;
  final String date;
  final String capacity;

  const LatestSearchObject(
      {required this.picUri,
      required this.destination,
      required this.date,
      required this.capacity});

  Widget buildWidget() => Card(
        elevation: 3,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: SizedBox(
                height: double.infinity,
                child: Image.asset(
                  picUri,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    destination,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$date, $capacity',
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class SearchObject {
  final Widget leading;
  final Widget title;
  final Widget? trailing;

  const SearchObject({
    required this.leading,
    required this.title,
    required this.trailing,
  });
}

class TabTuple {
  final Tab tab;
  final Widget page;
  const TabTuple({
    required this.tab,
    required this.page,
  });
}

class HomeData {
  static const searchObjects = <SearchObject>[
    SearchObject(
      leading: Icon(Icons.search),
      title: Text("Coron, Philippinen"),
      trailing: Icon(
        FontAwesomeIcons.microphone,
        size: 21,
      ),
    ),
    SearchObject(
        leading: Icon(Icons.calendar_month),
        title: Text("Mi. 14 Dez. - So. 18 Dez."),
        trailing: null),
    SearchObject(
      leading: Icon(Icons.person),
      title: Text(
        "1 Zimmer - 2 Erwachsene - Keine Kinder",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: null,
    ),
  ];

  static const latestSearches = <LatestSearchObject>[
    LatestSearchObject(
        picUri: 'assets/dummy/latestsearch/boracay.jpg',
        destination: 'Boracay',
        date: '14.-18. Dez.',
        capacity: '2 Erwachsene'),
    LatestSearchObject(
        picUri: 'assets/dummy/latestsearch/choclatehills.jpg',
        destination: 'Choclatte Hills',
        date: '1.-7. Jan.',
        capacity: '2 Erwachsene'),
    LatestSearchObject(
        picUri: 'assets/dummy/latestsearch/coron.jpeg',
        destination: 'Coron',
        date: '23.-27. Dez.',
        capacity: '2 Erwachsene'),
    LatestSearchObject(
        picUri: 'assets/dummy/latestsearch/kayangan.jpg',
        destination: 'Kayangan',
        date: '17.-23. Dez.',
        capacity: '2 Erwachsene'),
    LatestSearchObject(
        picUri: 'assets/dummy/latestsearch/palawan.jpg',
        destination: 'Palawan',
        date: '14.-17. Dez.',
        capacity: '2 Erwachsene'),
  ];

  static List<TabTuple> getTabTupe(double tabBarHeight) => [
        TabTuple(
          tab: const Tab(
            text: 'Animals',
          ),
          page: HomePageTab(
            items: TabBarData.animals,
            height: tabBarHeight,
          ),
        ),
        TabTuple(
          tab: const Tab(
            text: 'Beauty',
          ),
          page: HomePageTab(
            items: TabBarData.animals,
            height: tabBarHeight,
          ),
        ),
        TabTuple(
          tab: const Tab(
            text: 'Face',
          ),
          page: HomePageTab(
            items: TabBarData.animals,
            height: tabBarHeight,
          ),
        ),
        TabTuple(
          tab: const Tab(
            text: 'Female',
          ),
          page: HomePageTab(
            items: TabBarData.animals,
            height: tabBarHeight,
          ),
        ),
        TabTuple(
          tab: const Tab(
            text: 'Male',
          ),
          page: HomePageTab(
            items: TabBarData.animals,
            height: tabBarHeight,
          ),
        ),
        TabTuple(
          tab: const Tab(
            text: 'Massages',
          ),
          page: HomePageTab(
            items: TabBarData.animals,
            height: tabBarHeight,
          ),
        ),
        TabTuple(
          tab: const Tab(
            text: 'Pensioners',
          ),
          page: HomePageTab(
            items: TabBarData.animals,
            height: tabBarHeight,
          ),
        ),
        TabTuple(
          tab: const Tab(
            text: 'Tools',
          ),
          page: HomePageTab(
            items: TabBarData.animals,
            height: tabBarHeight,
          ),
        ),
      ];
}
