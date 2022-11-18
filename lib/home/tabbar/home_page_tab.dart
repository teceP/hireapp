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
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppFinals.borderRadius,
              ),
            ),
            elevation: AppFinals.elevation,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppFinals.borderRadius),
                        topRight: Radius.circular(AppFinals.borderRadius),
                      ),
                      child: Image.asset(
                        TabBarData.animals[index].picUri,
                        height: height * 0.5,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppFinals.horizontalPadding,
                        right: AppFinals.horizontalPadding,
                        top: AppFinals.verticalPadding,
                        //bottom: AppFinals.verticalPaddingAdditional,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            items[index].address,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 255, 203, 59),
                              ),
                              Text(
                                '${items[index].rating} ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${items[index].ratings} Bewertungen',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Chip(
                            label: Text(
                              items[index].advertisement,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.router.navigate(
                          ShopRouter(
                            shopId: 'shopId-$index',
                          ),
                        );
                      },
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          AppFinals.borderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: height,
            child: Card(
              color: Colors.blue,
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
