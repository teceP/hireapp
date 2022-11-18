import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/home/bottombar/bottom_bar_data.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  AppBar _buildTitleWidget(TabsRouter tabsRouter, BuildContext context) {
    final String path = tabsRouter.currentPath;

    switch (path) {
      default:
        return AppBar(
          title: Text(path),
          centerTitle: true,
          leading: const AutoLeadingButton(),
          actions: [
            IconButton(
              onPressed: () => context.router.navigate(ChatsRouter(
                children: [
                  ChatsRoute(),
                ],
              )),
              icon: const Icon(Icons.chat_bubble),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: Colors.grey[50],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBarBuilder: (context, tabsRouter) =>
          _buildTitleWidget(tabsRouter, context),
      routes: [
        ...BottomBarData.items.map((e) => e.router),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return Card(
          margin: EdgeInsets.zero,
          elevation: 20,
          child: SalomonBottomBar(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              ...BottomBarData.items.map((e) => e.bottomBarItem),
            ],
          ),
        );
      },
    );
  }
}
