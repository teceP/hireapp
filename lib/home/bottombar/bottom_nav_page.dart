import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/home/bottombar/bottom_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  AppBar _buildTitleWidget(TabsRouter tabsRouter, BuildContext context) {
    final String path = tabsRouter.currentPath;

    switch (path) {
      default:
        return AppBar(
          title: Text(
            AppFinals.appName,
            style: AppFinals.appNameTextStyle,
          ),
          centerTitle: true,
          leading: const AutoLeadingButton(),
          actions: [
            IconButton(
              onPressed: () => context.router.navigate(
                const ChatsRouter(
                  children: [
                    ChatsRoute(),
                  ],
                ),
              ),
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
