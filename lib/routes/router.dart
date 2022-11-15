import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:autoroutetest/booking/bookings_page.dart';
import 'package:autoroutetest/booking/single_booking_page.dart';
import 'package:autoroutetest/chats/chats_page.dart';
import 'package:autoroutetest/chats/single_chat_page.dart';
import 'package:autoroutetest/home/bottombar/bottom_nav_page.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/tabbar/beauty_search_page.dart';
import 'package:autoroutetest/home/home_page.dart';
import 'package:autoroutetest/favorites/favorites_page.dart';
import 'package:autoroutetest/home/tabbar/face_search_page.dart';
import 'package:autoroutetest/home/tabbar/male_search_page.dart';
import 'package:autoroutetest/home/tabbar/female_search_page.dart';
import 'package:autoroutetest/home/tabbar/massages_search_page.dart';
import 'package:autoroutetest/home/tabbar/pensioners_search_page.dart';
import 'package:autoroutetest/home/tabbar/tools_search_page.dart';
import 'package:autoroutetest/profiles/profiles_page.dart';
import 'package:autoroutetest/profiles/single_profile_page.dart';
import 'package:autoroutetest/search/search_page.dart';
import 'package:autoroutetest/unknown/unknown_page.dart';
import 'package:autoroutetest/shops/single_shop_page.dart';
import 'package:autoroutetest/shops/shops_page.dart';

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
      path: '/shops',
      name: 'ShopsRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          page: ShopsPage,
        ),
        AutoRoute(
          path: ':shopId',
          page: SingleShopPage,
        ),
      ],
    ),
    AutoRoute(
      path: '/search',
      name: 'SearchRouter',
      page: SearchPage,
      /*children: [
        AutoRoute(
          path: '',
          page: SearchPage,
        )
      ]*/
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
          path: 'profiles',
          name: 'ProfilesRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: ProfilesPage,
            ),
            AutoRoute(
              path: ':profileId',
              page: SingleProfilePage,
            ),
          ],
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
