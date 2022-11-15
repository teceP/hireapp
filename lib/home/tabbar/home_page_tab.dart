import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/commons/paging_scroll_physics.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:flutter/material.dart';

class HomePageTab extends StatelessWidget {
  final List<TabBarViewItem> items;
  final double height;

  const HomePageTab({required this.items, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.8;

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: PagingScrollPhysics(
        parent: const BouncingScrollPhysics(),
        itemDimension: itemWidth,
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: AppFinals.horizontalPadding),
      itemCount: TabBarData.animals.length + 1,
      itemExtent: itemWidth,
      itemBuilder: (context, index) {
        if (index < TabBarData.animals.length) {
          return InkWell(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              elevation: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        TabBarData.animals[index].picUri,
                        height: height * 0.5,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
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
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox(
            height: height,
            child: Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              elevation: 3,
              child: InkWell(
                onTap: () {},
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
