import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/chats/chats_page.dart';
import 'package:autoroutetest/home/home_data.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  RelativeRect getRelativeRect(BuildContext context) {
    final renderSliverList = context.findRenderObject() as RenderSliverList;

    print('TODO get relative rect of child');
    if (renderSliverList != null) {
      //renderSliverList.indexOf(0);
    }

    return const RelativeRect.fromLTRB(0, 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.only(
          //horizontal: AppFinals.horizontalPaddingLess,
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
          left: AppFinals.horizontalPaddingLess,
          right: AppFinals.horizontalPaddingLess,
        ),
        itemCount: TabBarData.animals.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
              top: 10,
              bottom: (index == (TabBarData.animals.length - 1)) ? 10 : 0),
          child: GestureDetector(
            onLongPress: (() {
              showMenu(
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
                  ]);
            }),
            child: PreviewCard(
              item: TabBarData.animals[index],
              shopId: '54321',
              height: Utils.h(context) * 0.3,
              tabBarDataIndex: index,
            ),
          ),
        ),
      ),
    );
  }
}
