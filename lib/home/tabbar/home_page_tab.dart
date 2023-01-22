import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/commons/paging_scroll_physics.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';

class HomePageTab extends StatelessWidget {
  final List<TabBarViewItem> items;
  final double height;
  final String tabName;

  const HomePageTab(
      {required this.tabName,
      required this.items,
      required this.height,
      super.key});

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.8;

    return ListView.builder(
      key: PageStorageKey(tabName),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: PagingScrollPhysics(
        parent: const BouncingScrollPhysics(),
        itemDimension: itemWidth,
      ),
      padding: const EdgeInsets.only(
        left: AppFinals.horizontalPadding,
        right: AppFinals.horizontalPadding,
        bottom: AppFinals.verticalPaddingAdditional,
      ),
      itemCount: TabBarData.animals.length + 1,
      itemExtent: itemWidth,
      itemBuilder: (context, index) {
        if (index < TabBarData.animals.length) {
          return PreviewCard(
            shopId: '1235',
            item: items[index],
            height: height,
            tabBarDataIndex: index,
          );
        } else {
          return SizedBox(
            height: height,
            child: Card(
              color: AppFinals.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppFinals.borderRadius,
                ),
              ),
              elevation: AppFinals.elevation,
              child: InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppFinals.borderRadius,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.arrow_forward,
                      ),
                      Text(
                        'Mehr',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class PreviewCard extends StatelessWidget {
  final TabBarViewItem item;
  final String shopId;
  final double height;
  final int tabBarDataIndex;

  const PreviewCard(
      {required this.shopId,
      required this.item,
      required this.height,
      required this.tabBarDataIndex,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(
        ShopRouter(shopId: shopId),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: AppFinals.horizontalPaddingLess,
          right: AppFinals.horizontalPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppFinals.borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3.0, 6.0),
                    blurRadius: 10,
                    color: Colors.black26,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppFinals.borderRadius),
                ),
                child: Image.asset(
                  TabBarData.animals[tabBarDataIndex].picUri,
                  height: height * 0.75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                item.title,
                style: TextStyle(
                  color: AppFinals.primaryColorDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                item.address,
                style: TextStyle(color: AppFinals.thirdColorGreened),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppFinals.primaryColor,
                  borderRadius: BorderRadius.circular(
                    AppFinals.borderRadius,
                  ),
                ),
                child: Text(
                  item.advertisement,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
