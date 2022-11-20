// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i17;
import 'package:flutter/material.dart' as _i16;

import '../booking/bookings_page.dart' as _i11;
import '../booking/single_booking_page.dart' as _i12;
import '../chats/chats_page.dart' as _i6;
import '../chats/single_chat_page.dart' as _i7;
import '../favorites/favorites_page.dart' as _i9;
import '../home/bottombar/bottom_nav_page.dart' as _i5;
import '../home/home_page.dart' as _i8;
import '../profiles/profiles_page.dart' as _i13;
import '../profiles/single_profile_page.dart' as _i14;
import '../search/map_page.dart' as _i4;
import '../search/search_page.dart' as _i3;
import '../shops/shop_page.dart' as _i2;
import '../unknown/unknown_page.dart' as _i10;

class AppRouter extends _i15.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    ChatsRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    ShopRouter.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ShopRouterArgs>(
          orElse: () => ShopRouterArgs(shopId: pathParams.getString('shopId')));
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.ShopPage(
          shopId: args.shopId,
          key: args.key,
        ),
      );
    },
    SearchRouter.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<SearchRouterArgs>(
          orElse: () => SearchRouterArgs(
                query: queryParams.optString('query'),
                postalCode: queryParams.optInt('postalCode'),
                datestart: queryParams.optString('datestart'),
                dateend: queryParams.optString('dateend'),
                pricemax: queryParams.optString('pricemax'),
                pricemin: queryParams.optString('pricemin'),
              ));
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.SearchPage(
          query: args.query,
          postalCode: args.postalCode,
          datestart: args.datestart,
          dateend: args.dateend,
          pricemax: args.pricemax,
          pricemin: args.pricemin,
          key: args.key,
        ),
      );
    },
    MapRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.MapPage(),
      );
    },
    BottomNavRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.BottomNavPage(),
      );
    },
    ChatsRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ChatsPage(),
      );
    },
    SingleChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleChatRouteArgs>(
          orElse: () => SingleChatRouteArgs(chatId: pathParams.get('chatId')));
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.SingleChatPage(
          chatId: args.chatId,
          key: args.key,
        ),
      );
    },
    HomeRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.HomePage(),
      );
    },
    FavoritesRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.FavoritesPage(),
      );
    },
    BookingsRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    ProfilesRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    UnknownRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.UnknownPage(),
      );
    },
    BookingsRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.BookingsPage(),
      );
    },
    SingleBookingRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleBookingRouteArgs>(
          orElse: () =>
              SingleBookingRouteArgs(bookingId: pathParams.get('bookingId')));
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.SingleBookingPage(
          bookingId: args.bookingId,
          key: args.key,
        ),
      );
    },
    ProfilesRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.ProfilesPage(),
      );
    },
    SingleProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleProfileRouteArgs>(
          orElse: () =>
              SingleProfileRouteArgs(profileId: pathParams.get('profileId')));
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.SingleProfilePage(
          profileId: args.profileId,
          key: args.key,
        ),
      );
    },
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(
          ChatsRouter.name,
          path: '/chats',
          children: [
            _i15.RouteConfig(
              ChatsRoute.name,
              path: '',
              parent: ChatsRouter.name,
            ),
            _i15.RouteConfig(
              SingleChatRoute.name,
              path: ':chatId',
              parent: ChatsRouter.name,
            ),
          ],
        ),
        _i15.RouteConfig(
          ShopRouter.name,
          path: '/shops/:shopId',
        ),
        _i15.RouteConfig(
          SearchRouter.name,
          path: '/search',
        ),
        _i15.RouteConfig(
          MapRouter.name,
          path: '/map:geopoints',
        ),
        _i15.RouteConfig(
          BottomNavRoute.name,
          path: '/',
          children: [
            _i15.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: BottomNavRoute.name,
            ),
            _i15.RouteConfig(
              FavoritesRouter.name,
              path: 'favorites',
              parent: BottomNavRoute.name,
            ),
            _i15.RouteConfig(
              BookingsRouter.name,
              path: 'bookings',
              parent: BottomNavRoute.name,
              children: [
                _i15.RouteConfig(
                  BookingsRoute.name,
                  path: '',
                  parent: BookingsRouter.name,
                ),
                _i15.RouteConfig(
                  SingleBookingRoute.name,
                  path: ':bookingId',
                  parent: BookingsRouter.name,
                ),
              ],
            ),
            _i15.RouteConfig(
              ProfilesRouter.name,
              path: 'profiles',
              parent: BottomNavRoute.name,
              children: [
                _i15.RouteConfig(
                  ProfilesRoute.name,
                  path: '',
                  parent: ProfilesRouter.name,
                ),
                _i15.RouteConfig(
                  SingleProfileRoute.name,
                  path: ':profileId',
                  parent: ProfilesRouter.name,
                ),
              ],
            ),
            _i15.RouteConfig(
              UnknownRoute.name,
              path: '*',
              parent: BottomNavRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class ChatsRouter extends _i15.PageRouteInfo<void> {
  const ChatsRouter({List<_i15.PageRouteInfo>? children})
      : super(
          ChatsRouter.name,
          path: '/chats',
          initialChildren: children,
        );

  static const String name = 'ChatsRouter';
}

/// generated route for
/// [_i2.ShopPage]
class ShopRouter extends _i15.PageRouteInfo<ShopRouterArgs> {
  ShopRouter({
    required String shopId,
    _i17.Key? key,
  }) : super(
          ShopRouter.name,
          path: '/shops/:shopId',
          args: ShopRouterArgs(
            shopId: shopId,
            key: key,
          ),
          rawPathParams: {'shopId': shopId},
        );

  static const String name = 'ShopRouter';
}

class ShopRouterArgs {
  const ShopRouterArgs({
    required this.shopId,
    this.key,
  });

  final String shopId;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ShopRouterArgs{shopId: $shopId, key: $key}';
  }
}

/// generated route for
/// [_i3.SearchPage]
class SearchRouter extends _i15.PageRouteInfo<SearchRouterArgs> {
  SearchRouter({
    String? query,
    int? postalCode,
    String? datestart,
    String? dateend,
    String? pricemax,
    String? pricemin,
    _i17.Key? key,
  }) : super(
          SearchRouter.name,
          path: '/search',
          args: SearchRouterArgs(
            query: query,
            postalCode: postalCode,
            datestart: datestart,
            dateend: dateend,
            pricemax: pricemax,
            pricemin: pricemin,
            key: key,
          ),
          rawQueryParams: {
            'query': query,
            'postalCode': postalCode,
            'datestart': datestart,
            'dateend': dateend,
            'pricemax': pricemax,
            'pricemin': pricemin,
          },
        );

  static const String name = 'SearchRouter';
}

class SearchRouterArgs {
  const SearchRouterArgs({
    this.query,
    this.postalCode,
    this.datestart,
    this.dateend,
    this.pricemax,
    this.pricemin,
    this.key,
  });

  final String? query;

  final int? postalCode;

  final String? datestart;

  final String? dateend;

  final String? pricemax;

  final String? pricemin;

  final _i17.Key? key;

  @override
  String toString() {
    return 'SearchRouterArgs{query: $query, postalCode: $postalCode, datestart: $datestart, dateend: $dateend, pricemax: $pricemax, pricemin: $pricemin, key: $key}';
  }
}

/// generated route for
/// [_i4.MapPage]
class MapRouter extends _i15.PageRouteInfo<void> {
  const MapRouter()
      : super(
          MapRouter.name,
          path: '/map:geopoints',
        );

  static const String name = 'MapRouter';
}

/// generated route for
/// [_i5.BottomNavPage]
class BottomNavRoute extends _i15.PageRouteInfo<void> {
  const BottomNavRoute({List<_i15.PageRouteInfo>? children})
      : super(
          BottomNavRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'BottomNavRoute';
}

/// generated route for
/// [_i6.ChatsPage]
class ChatsRoute extends _i15.PageRouteInfo<void> {
  const ChatsRoute()
      : super(
          ChatsRoute.name,
          path: '',
        );

  static const String name = 'ChatsRoute';
}

/// generated route for
/// [_i7.SingleChatPage]
class SingleChatRoute extends _i15.PageRouteInfo<SingleChatRouteArgs> {
  SingleChatRoute({
    required dynamic chatId,
    _i17.Key? key,
  }) : super(
          SingleChatRoute.name,
          path: ':chatId',
          args: SingleChatRouteArgs(
            chatId: chatId,
            key: key,
          ),
          rawPathParams: {'chatId': chatId},
        );

  static const String name = 'SingleChatRoute';
}

class SingleChatRouteArgs {
  const SingleChatRouteArgs({
    required this.chatId,
    this.key,
  });

  final dynamic chatId;

  final _i17.Key? key;

  @override
  String toString() {
    return 'SingleChatRouteArgs{chatId: $chatId, key: $key}';
  }
}

/// generated route for
/// [_i8.HomePage]
class HomeRouter extends _i15.PageRouteInfo<void> {
  const HomeRouter()
      : super(
          HomeRouter.name,
          path: 'home',
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i9.FavoritesPage]
class FavoritesRouter extends _i15.PageRouteInfo<void> {
  const FavoritesRouter()
      : super(
          FavoritesRouter.name,
          path: 'favorites',
        );

  static const String name = 'FavoritesRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class BookingsRouter extends _i15.PageRouteInfo<void> {
  const BookingsRouter({List<_i15.PageRouteInfo>? children})
      : super(
          BookingsRouter.name,
          path: 'bookings',
          initialChildren: children,
        );

  static const String name = 'BookingsRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class ProfilesRouter extends _i15.PageRouteInfo<void> {
  const ProfilesRouter({List<_i15.PageRouteInfo>? children})
      : super(
          ProfilesRouter.name,
          path: 'profiles',
          initialChildren: children,
        );

  static const String name = 'ProfilesRouter';
}

/// generated route for
/// [_i10.UnknownPage]
class UnknownRoute extends _i15.PageRouteInfo<void> {
  const UnknownRoute()
      : super(
          UnknownRoute.name,
          path: '*',
        );

  static const String name = 'UnknownRoute';
}

/// generated route for
/// [_i11.BookingsPage]
class BookingsRoute extends _i15.PageRouteInfo<void> {
  const BookingsRoute()
      : super(
          BookingsRoute.name,
          path: '',
        );

  static const String name = 'BookingsRoute';
}

/// generated route for
/// [_i12.SingleBookingPage]
class SingleBookingRoute extends _i15.PageRouteInfo<SingleBookingRouteArgs> {
  SingleBookingRoute({
    required dynamic bookingId,
    _i17.Key? key,
  }) : super(
          SingleBookingRoute.name,
          path: ':bookingId',
          args: SingleBookingRouteArgs(
            bookingId: bookingId,
            key: key,
          ),
          rawPathParams: {'bookingId': bookingId},
        );

  static const String name = 'SingleBookingRoute';
}

class SingleBookingRouteArgs {
  const SingleBookingRouteArgs({
    required this.bookingId,
    this.key,
  });

  final dynamic bookingId;

  final _i17.Key? key;

  @override
  String toString() {
    return 'SingleBookingRouteArgs{bookingId: $bookingId, key: $key}';
  }
}

/// generated route for
/// [_i13.ProfilesPage]
class ProfilesRoute extends _i15.PageRouteInfo<void> {
  const ProfilesRoute()
      : super(
          ProfilesRoute.name,
          path: '',
        );

  static const String name = 'ProfilesRoute';
}

/// generated route for
/// [_i14.SingleProfilePage]
class SingleProfileRoute extends _i15.PageRouteInfo<SingleProfileRouteArgs> {
  SingleProfileRoute({
    required dynamic profileId,
    _i17.Key? key,
  }) : super(
          SingleProfileRoute.name,
          path: ':profileId',
          args: SingleProfileRouteArgs(
            profileId: profileId,
            key: key,
          ),
          rawPathParams: {'profileId': profileId},
        );

  static const String name = 'SingleProfileRoute';
}

class SingleProfileRouteArgs {
  const SingleProfileRouteArgs({
    required this.profileId,
    this.key,
  });

  final dynamic profileId;

  final _i17.Key? key;

  @override
  String toString() {
    return 'SingleProfileRouteArgs{profileId: $profileId, key: $key}';
  }
}
