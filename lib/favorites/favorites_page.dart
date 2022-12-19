import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/chats/chats_page.dart';
import 'package:autoroutetest/home/home_data.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppFinals.horizontalPaddingLess,
        ),
        itemCount: TabBarData.animals.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
              top: 10,
              bottom: (index == (TabBarData.animals.length - 1)) ? 10 : 0),
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
