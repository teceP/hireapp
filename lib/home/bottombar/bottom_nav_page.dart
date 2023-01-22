import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/home/bottombar/bottom_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppFinals.backgroundColor,
      /*padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: MediaQuery.of(context).padding.bottom,
      ),*/
      child: AutoTabsScaffold(
        backgroundColor: Colors.grey[50],
        drawer: _buildDrawer(context),
        //appBarBuilder: (context, tabsRouter) => _buildAppBar(tabsRouter, context),
        routes: [
          ...BottomBarData.items.map((e) => e.router),
        ],
        bottomNavigationBuilder: (context, tabsRouter) {
          return Container(
            decoration: BoxDecoration(
              color: AppFinals.backgroundColor,
            ),
            child: SalomonBottomBar(
              margin: const EdgeInsets.symmetric(
                horizontal: AppFinals.horizontalPadding,
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
      ),
    );
  }

  AppBar? _buildAppBar(TabsRouter tabsRouter, BuildContext context) {
    final String path = tabsRouter.currentPath;
    switch (path) {
      default:
        return AppBar(
          title: Text(
            AppFinals.appName,
            style: AppFinals.appNameTextStyle,
          ),
          centerTitle: true,
          //leading: const AutoLeadingButton(), //causes bug: sometimes appears on homepages and removes overlays on drawer
          actions: [
            IconButton(
              onPressed: () => context.router.navigate(
                const ChatsRouter(
                  children: [
                    ChatsRoute(),
                  ],
                ),
              ),
              icon: const Icon(Icons.local_post_office),
            ),
          ],
        );
    }
  }

  Drawer _buildDrawer(BuildContext context) => Drawer(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          width: double.infinity,
          child: Column(
            //padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppFinals.appBarColor,
                ),
                margin: EdgeInsets.zero,
                child: const SizedBox(
                  width: double.infinity,
                  child: Text('Drawer Header'),
                ),
              ),
              ListTile(
                style: ListTileStyle.drawer,
                title: const Text('Deinen Shop anbieten'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Einstellungen'),
                onTap: () => context.router.push(
                  SettingsRouter(userId: 'USERID'),
                ),
              ),
              const Spacer(),
              ListTile(
                title: const Text(
                  'AGB',
                  style: TextStyle(color: Colors.black54),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Lizenzen',
                  style: TextStyle(color: Colors.black54),
                ),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: AppFinals.appName,
                    applicationVersion: 'Version ${AppFinals.appVersion}',
                    applicationIcon: const Icon(FontAwesomeIcons.amazon),
                    applicationLegalese: 'Copyrights to Mario Teklic',
                  );
                },
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Buy me a coffee',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      FontAwesomeIcons.mugSaucer,
                      size: 18,
                    )
                  ],
                ),
                onTap: () {},
              ),
              Container(
                height: AppBar().preferredSize.height * 2,
                width: double.infinity,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      );
}
