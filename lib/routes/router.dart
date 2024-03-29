import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:autoroutetest/booking/bookings_page.dart';
import 'package:autoroutetest/booking/single_booking_page.dart';
import 'package:autoroutetest/chats/chats_page.dart';
import 'package:autoroutetest/chats/single_chat_page.dart';
import 'package:autoroutetest/home/bottombar/bottom_nav_page.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/home_page.dart';
import 'package:autoroutetest/favorites/favorites_page.dart';
import 'package:autoroutetest/profile/profile_page.dart';
import 'package:autoroutetest/profile/signe_in_page.dart';
import 'package:autoroutetest/search/filter_page.dart';
import 'package:autoroutetest/search/map_page.dart';
import 'package:autoroutetest/search/search_page.dart';
import 'package:autoroutetest/settings/settings_page.dart';
import 'package:autoroutetest/unknown/unknown_page.dart';
import 'package:autoroutetest/shops/shop_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/chats',
      name: 'ChatsRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          page: ChatsPage,
        ),
        AutoRoute(
          path: ':chatId',
          page: SingleChatPage,
        ),
      ],
    ),
    AutoRoute(
      path: '/shops/:shopId',
      name: 'ShopRouter',
      page: ShopPage,
    ),
    AutoRoute(
      path: '/search',
      name: 'SearchRouter',
      page: SearchPage,
    ),
    AutoRoute(
      path: '/filter:queryId',
      name: 'FilterRouter',
      page: FilterPage,
    ),
    AutoRoute(
      path: '/map:geopoints',
      name: 'MapRouter',
      page: MapPage,
    ),
    AutoRoute(
      path: '/settings/:userId',
      name: 'SettingsRouter',
      page: SettingsPage,
    ),
    AutoRoute(
      path: '/',
      page: BottomNavPage,
      children: [
        AutoRoute(
          path: 'home',
          name: 'HomeRouter',
          page: HomePage,
        ),
        AutoRoute(
          path: 'favorites',
          name: 'FavoritesRouter',
          page: FavoritesPage,
        ),
        AutoRoute(
          path: 'bookings',
          name: 'BookingsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: BookingsPage,
            ),
            AutoRoute(
              path: ':bookingId',
              page: SingleBookingPage,
            ),
          ],
        ),
        AutoRoute(
          path: 'profile',
          name: 'ProfileRouter',
          page: ProfilePage,
        ),
        AutoRoute(
          path: 'signin',
          name: 'SignInRouter',
          page: SignInPage,
        ),
        AutoRoute(
          path: '*',
          page: UnknownPage,
        ),
      ],
    ),
  ],
)
class $AppRouter {}
