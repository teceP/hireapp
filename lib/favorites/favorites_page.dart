import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/chats/chats_page.dart';
import 'package:autoroutetest/home/home_data.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/search/simple_search_bar.dart';
import 'package:autoroutetest/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
          elevation: 0,
          flexibleSpace: SimpleSearchBar(
            suggestionTextStyle: GoogleFonts.roboto().copyWith(
              fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
              color: Colors.black,
            ),
            backgroundColor: AppFinals.backgroundColor,
            elevation: _isScrolledToTop ? 0 : 2,
            suggestions: TabBarData.animals.map((e) => e.title).toList(),
            suggestionsElevation: 0,
            appBarHeight: AppBar().preferredSize.height,
            title: Text(
              'Favoriten',
              style: GoogleFonts.roboto().copyWith(
                color: AppFinals.primaryColorDark,
                fontSize: Theme.of(context).textTheme.headline5!.fontSize,
              ),
            ),
            iconTheme: IconTheme.of(context).copyWith(
              color: AppFinals.primaryColorDark,
            ),
            searchBackIconTheme: IconTheme.of(context).copyWith(
              color: Colors.black,
            ),
            onSearch: (value) {
              print(value);
            },
            onSuggestionTap: (value) {
              print('onTap $value');
            },
            isFloating: true,
          ),
        ),
        body: _buildFavorites(context),
      ),
    );
  }

  Widget _buildFavorites(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.only(
        //horizontal: AppFinals.horizontalPaddingLess,
        top: AppFinals.verticalPadding,
        bottom: MediaQuery.of(context).padding.bottom,
        left: AppFinals.horizontalPadding,
        right: AppFinals.horizontalPaddingLess,
      ),
      itemCount: TabBarData.animals.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(
          //top: 10,
          bottom: 10,
        ),
        child: GestureDetector(
          onLongPress: (() {
            /*showMenu(
                context: context,
                position: getRelativeRect(context),
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                      child: const Text(
                        'Entfernen',
                      ),
                      onTap: () {
                        print('To be implemented');
                      }),
                ]);*/
          }),
          child: PreviewCard(
            item: TabBarData.animals[index],
            shopId: '54321',
            height: Utils.h(context) * 0.3,
            tabBarDataIndex: index,
          ),
        ),
      ),
    );
  }
}
