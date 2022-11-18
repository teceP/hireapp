import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBarTuple {
  final SalomonBottomBarItem bottomBarItem;
  final PageRouteInfo router;

  const BottomNavBarTuple({required this.bottomBarItem, required this.router});
}

class BottomBarData {
  static final items = [
    BottomNavBarTuple(
        bottomBarItem: SalomonBottomBarItem(
          title: const Text('Suchen'),
          selectedColor: Colors.blue[200],
          icon: const Icon(
            FontAwesomeIcons.toolbox,
            size: 25,
          ),
        ),
        router: HomeRouter()),
    BottomNavBarTuple(
        bottomBarItem: SalomonBottomBarItem(
          title: const Text('Favoriten'),
          selectedColor: Colors.blue[200],
          icon: const Icon(
            FontAwesomeIcons.heart,
            size: 25,
          ),
        ),
        router: const FavoritesRouter()),
    BottomNavBarTuple(
        bottomBarItem: SalomonBottomBarItem(
          title: const Text('Buchungen'),
          selectedColor: Colors.blue[200],
          icon: const Icon(
            FontAwesomeIcons.calendarDays,
            size: 25,
          ),
        ),
        router: const BookingsRouter()),
    BottomNavBarTuple(
        bottomBarItem: SalomonBottomBarItem(
          title: const Text('Profil'),
          selectedColor: Colors.blue[200],
          icon: const Icon(
            FontAwesomeIcons.userAstronaut,
            size: 25,
          ),
        ),
        router: const ProfilesRouter()),
  ];
}
