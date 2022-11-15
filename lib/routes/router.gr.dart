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
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i19;
import 'package:flutter/material.dart' as _i18;

import '../booking/bookings_page.dart' as _i13;
import '../booking/single_booking_page.dart' as _i14;
import '../home/bottombar/bottom_nav_page.dart' as _i3;
import '../chats/chats_page.dart' as _i4;
import '../chats/single_chat_page.dart' as _i5;
import '../favorites/favorites_page.dart' as _i9;
import '../home/tabbar/beauty_search_page.dart' as _i11;
import '../home/home_page.dart' as _i8;
import '../home/tabbar/tools_search_page.dart' as _i12;
import '../profiles/profiles_page.dart' as _i15;
import '../profiles/single_profile_page.dart' as _i16;
import '../search/search_page.dart' as _i2;
import '../shops/shops_page.dart' as _i6;
import '../shops/single_shop_page.dart' as _i7;
import '../unknown/unknown_page.dart' as _i10;

class AppRouter extends _i17.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    ChatsRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    ShopsRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    SearchRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SearchPage(),
      );
    },
    BottomNavRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.BottomNavPage(),
      );
    },
    ChatsRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.ChatsPage(),
      );
    },
    SingleChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleChatRouteArgs>(
          orElse: () => SingleChatRouteArgs(chatId: pathParams.get('chatId')));
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SingleChatPage(
          chatId: args.chatId,
          key: args.key,
        ),
      );
    },
    ShopsRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ShopsPage(),
      );
    },
    SingleShopRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleShopRouteArgs>(
          orElse: () =>
              SingleShopRouteArgs(shopId: pathParams.getString('shopId')));
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.SingleShopPage(
          shopId: args.shopId,
          key: args.key,
        ),
      );
    },
    HomeRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.HomePage(),
      );
    },
    FavoritesRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.FavoritesPage(),
      );
    },
    BookingsRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    ProfilesRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    UnknownRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.UnknownPage(),
      );
    },
    BeautySearchRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.BeautySearchPage(),
      );
    },
    ToolsSearchRouter.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.ToolsSearchPage(),
      );
    },
    BookingsRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.BookingsPage(),
      );
    },
    SingleBookingRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleBookingRouteArgs>(
          orElse: () =>
              SingleBookingRouteArgs(bookingId: pathParams.get('bookingId')));
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.SingleBookingPage(
          bookingId: args.bookingId,
          key: args.key,
        ),
      );
    },
    ProfilesRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.ProfilesPage(),
      );
    },
    SingleProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleProfileRouteArgs>(
          orElse: () =>
              SingleProfileRouteArgs(profileId: pathParams.get('profileId')));
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.SingleProfilePage(
          profileId: args.profileId,
          key: args.key,
        ),
      );
    },
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(
          ChatsRouter.name,
          path: '/chats',
          children: [
            _i17.RouteConfig(
              ChatsRoute.name,
              path: '',
              parent: ChatsRouter.name,
            ),
            _i17.RouteConfig(
              SingleChatRoute.name,
              path: ':chatId',
              parent: ChatsRouter.name,
            ),
          ],
        ),
        _i17.RouteConfig(
          ShopsRouter.name,
          path: '/shops',
          children: [
            _i17.RouteConfig(
              ShopsRoute.name,
              path: '',
              parent: ShopsRouter.name,
            ),
            _i17.RouteConfig(
              SingleShopRoute.name,
              path: ':shopId',
              parent: ShopsRouter.name,
            ),
          ],
        ),
        _i17.RouteConfig(
          SearchRouter.name,
          path: '/search',
        ),
        _i17.RouteConfig(
          BottomNavRoute.name,
          path: '/',
          children: [
            _i17.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: BottomNavRoute.name,
              children: [
                _i17.RouteConfig(
                  BeautySearchRouter.name,
                  path: 'beauty',
                  parent: HomeRouter.name,
                ),
                _i17.RouteConfig(
                  ToolsSearchRouter.name,
                  path: 'tools',
                  parent: HomeRouter.name,
                ),
              ],
            ),
            _i17.RouteConfig(
              FavoritesRouter.name,
              path: 'favorites',
              parent: BottomNavRoute.name,
            ),
            _i17.RouteConfig(
              BookingsRouter.name,
              path: 'bookings',
              parent: BottomNavRoute.name,
              children: [
                _i17.RouteConfig(
                  BookingsRoute.name,
                  path: '',
                  parent: BookingsRouter.name,
                ),
                _i17.RouteConfig(
                  SingleBookingRoute.name,
                  path: ':bookingId',
                  parent: BookingsRouter.name,
                ),
              ],
            ),
            _i17.RouteConfig(
              ProfilesRouter.name,
              path: 'profiles',
              parent: BottomNavRoute.name,
              children: [
                _i17.RouteConfig(
                  ProfilesRoute.name,
                  path: '',
                  parent: ProfilesRouter.name,
                ),
                _i17.RouteConfig(
                  SingleProfileRoute.name,
                  path: ':profileId',
                  parent: ProfilesRouter.name,
                ),
              ],
            ),
            _i17.RouteConfig(
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
class ChatsRouter extends _i17.PageRouteInfo<void> {
  const ChatsRouter({List<_i17.PageRouteInfo>? children})
      : super(
          ChatsRouter.name,
          path: '/chats',
          initialChildren: children,
        );

  static const String name = 'ChatsRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class ShopsRouter extends _i17.PageRouteInfo<void> {
  const ShopsRouter({List<_i17.PageRouteInfo>? children})
      : super(
          ShopsRouter.name,
          path: '/shops',
          initialChildren: children,
        );

  static const String name = 'ShopsRouter';
}

/// generated route for
/// [_i2.SearchPage]
class SearchRouter extends _i17.PageRouteInfo<void> {
  const SearchRouter()
      : super(
          SearchRouter.name,
          path: '/search',
        );

  static const String name = 'SearchRouter';
}

/// generated route for
/// [_i3.BottomNavPage]
class BottomNavRoute extends _i17.PageRouteInfo<void> {
  const BottomNavRoute({List<_i17.PageRouteInfo>? children})
      : super(
          BottomNavRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'BottomNavRoute';
}

/// generated route for
/// [_i4.ChatsPage]
class ChatsRoute extends _i17.PageRouteInfo<void> {
  const ChatsRoute()
      : super(
          ChatsRoute.name,
          path: '',
        );

  static const String name = 'ChatsRoute';
}

/// generated route for
/// [_i5.SingleChatPage]
class SingleChatRoute extends _i17.PageRouteInfo<SingleChatRouteArgs> {
  SingleChatRoute({
    required dynamic chatId,
    _i19.Key? key,
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

  final _i19.Key? key;

  @override
  String toString() {
    return 'SingleChatRouteArgs{chatId: $chatId, key: $key}';
  }
}

/// generated route for
/// [_i6.ShopsPage]
class ShopsRoute extends _i17.PageRouteInfo<void> {
  const ShopsRoute()
      : super(
          ShopsRoute.name,
          path: '',
        );

  static const String name = 'ShopsRoute';
}

/// generated route for
/// [_i7.SingleShopPage]
class SingleShopRoute extends _i17.PageRouteInfo<SingleShopRouteArgs> {
  SingleShopRoute({
    required String shopId,
    _i19.Key? key,
  }) : super(
          SingleShopRoute.name,
          path: ':shopId',
          args: SingleShopRouteArgs(
            shopId: shopId,
            key: key,
          ),
          rawPathParams: {'shopId': shopId},
        );

  static const String name = 'SingleShopRoute';
}

class SingleShopRouteArgs {
  const SingleShopRouteArgs({
    required this.shopId,
    this.key,
  });

  final String shopId;

  final _i19.Key? key;

  @override
  String toString() {
    return 'SingleShopRouteArgs{shopId: $shopId, key: $key}';
  }
}

/// generated route for
/// [_i8.HomePage]
class HomeRouter extends _i17.PageRouteInfo<void> {
  const HomeRouter({List<_i17.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i9.FavoritesPage]
class FavoritesRouter extends _i17.PageRouteInfo<void> {
  const FavoritesRouter()
      : super(
          FavoritesRouter.name,
          path: 'favorites',
        );

  static const String name = 'FavoritesRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class BookingsRouter extends _i17.PageRouteInfo<void> {
  const BookingsRouter({List<_i17.PageRouteInfo>? children})
      : super(
          BookingsRouter.name,
          path: 'bookings',
          initialChildren: children,
        );

  static const String name = 'BookingsRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class ProfilesRouter extends _i17.PageRouteInfo<void> {
  const ProfilesRouter({List<_i17.PageRouteInfo>? children})
      : super(
          ProfilesRouter.name,
          path: 'profiles',
          initialChildren: children,
        );

  static const String name = 'ProfilesRouter';
}

/// generated route for
/// [_i10.UnknownPage]
class UnknownRoute extends _i17.PageRouteInfo<void> {
  const UnknownRoute()
      : super(
          UnknownRoute.name,
          path: '*',
        );

  static const String name = 'UnknownRoute';
}

/// generated route for
/// [_i11.BeautySearchPage]
class BeautySearchRouter extends _i17.PageRouteInfo<void> {
  const BeautySearchRouter()
      : super(
          BeautySearchRouter.name,
          path: 'beauty',
        );

  static const String name = 'BeautySearchRouter';
}

/// generated route for
/// [_i12.ToolsSearchPage]
class ToolsSearchRouter extends _i17.PageRouteInfo<void> {
  const ToolsSearchRouter()
      : super(
          ToolsSearchRouter.name,
          path: 'tools',
        );

  static const String name = 'ToolsSearchRouter';
}

/// generated route for
/// [_i13.BookingsPage]
class BookingsRoute extends _i17.PageRouteInfo<void> {
  const BookingsRoute()
      : super(
          BookingsRoute.name,
          path: '',
        );

  static const String name = 'BookingsRoute';
}

/// generated route for
/// [_i14.SingleBookingPage]
class SingleBookingRoute extends _i17.PageRouteInfo<SingleBookingRouteArgs> {
  SingleBookingRoute({
    required dynamic bookingId,
    _i19.Key? key,
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

  final _i19.Key? key;

  @override
  String toString() {
    return 'SingleBookingRouteArgs{bookingId: $bookingId, key: $key}';
  }
}

/// generated route for
/// [_i15.ProfilesPage]
class ProfilesRoute extends _i17.PageRouteInfo<void> {
  const ProfilesRoute()
      : super(
          ProfilesRoute.name,
          path: '',
        );

  static const String name = 'ProfilesRoute';
}

/// generated route for
/// [_i16.SingleProfilePage]
class SingleProfileRoute extends _i17.PageRouteInfo<SingleProfileRouteArgs> {
  SingleProfileRoute({
    required dynamic profileId,
    _i19.Key? key,
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

  final _i19.Key? key;

  @override
  String toString() {
    return 'SingleProfileRouteArgs{profileId: $profileId, key: $key}';
  }
}
