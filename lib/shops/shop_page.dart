import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

class ShopPage extends StatefulWidget {
  final String shopId;

  const ShopPage({@PathParam() required this.shopId, super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _activePage = 0;
  final Color _checkAvailabilityColor = Colors.deepOrange;
  late AnimationController _cartAnimationController;

  @override
  void initState() {
    _cartAnimationController = AnimationController(
      vsync: this,
      duration: AppFinals.animationDuration,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: !hasAnyInCart()
          ? null
          : [
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0),
                  end: const Offset(0, 0),
                ).animate(_cartAnimationController),
                child: ListTile(
                  title: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _checkAvailabilityColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Verfügbarkeit prüfen'),
                          const SizedBox(
                            width: AppFinals.commonWidgetDistance,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppFinals.horizontalPaddingLess,
                              vertical: AppFinals.verticalPaddingAdditional,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppFinals.borderRadius),
                                color: Colors.white),
                            child: Text(
                              '${_cart.values.where((element) => element == true).length}',
                              style: TextStyle(
                                color: _checkAvailabilityColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(context),
          for (final w in _buildBody())
            SliverToBoxAdapter(
              child: w,
            ),
        ],
      ),
    );
  }

  List<Widget> _buildBody() {
    return [
      //const LikeButton(),
      __buildTitleRow(),
      __buildRatingRow(),
      const Divider(),
      __buildShopInfos(),
      __buildDivider(),
      for (final w in __buildServices()) w,
      SizedBox(
        height: MediaQuery.of(context).padding.bottom,
      ),
    ];
  }

  bool hasAnyInCart() {
    return _cart.values.any((element) => element == true);
  }

  bool _liked = false;

  Widget __buildTitleRow() => ListTile(
        title: Text(
          'Schlumilu - Pannierstraße',
          style: Theme.of(context).textTheme.headline5!,
        ),
        trailing: IconButton(
          onPressed: (() {
            setState(() {
              _liked = !_liked;
            });
          }),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutCirc,
            switchOutCurve: Curves.easeInCirc,
            transitionBuilder: (child, anim) => RotationTransition(
              turns: child.key == const ValueKey('likedicon1')
                  ? Tween<double>(begin: 0, end: 0.0000001).animate(anim)
                  : Tween<double>(begin: 0, end: 0.0000001).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: _liked == false
                ? const Icon(
                    FontAwesomeIcons.heart,
                    color: Colors.redAccent,
                    key: ValueKey('likedicon1'),
                  )
                : const Icon(
                    FontAwesomeIcons.heartCircleCheck,
                    color: Colors.redAccent,
                    key: ValueKey('icon2'),
                  ),
          ),
        ),
      );

  Widget __buildRatingRow() => ListTile(
        title: Row(
          children: [
            const Text(
              '5.0',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            RatingBar.builder(
              initialRating: 5.0,
              minRating: 0,
              allowHalfRating: true,
              unratedColor: Colors.amber.withAlpha(50),
              itemCount: 5,
              itemSize: Theme.of(context).textTheme.headline6!.fontSize!,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              glow: false,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: ((value) {}),
              updateOnDrag: true,
            ),
            const SizedBox(
              width: AppFinals.commonWidgetDistance,
            ),
            const Text(
              '562 Bewertungen',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: AppFinals.navigageNextIcon,
        ),
      );

  Widget __buildShopInfos() => ListTile(
        title: const Text(
          'Shopinfos ansehen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Pannierstraße 28, Berlin, Neukölln'),
        trailing: IconButton(
          onPressed: () {},
          icon: AppFinals.navigageNextIcon,
        ),
      );

  Widget __buildDivider() => Container(
        height: 5,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
      );

  List<Widget> __buildServices() {
    List<Widget> items = [];

    items
      ..add(
        _buildServiceExpansionTile(
          true,
          [1],
          'Herrenhaarschnitt',
          [
            _buildServiceListTile(
                1, 'Herren - Cut & Style', '45 Min', 39.99, () {}),
          ],
        ),
      )
      ..add(
        _buildServiceExpansionTile(
          true,
          [2, 3],
          'Damenhaarschnitt',
          [
            _buildServiceListTile(
                2, 'Damen - Cut & Style', '45 Min', 54.99, () {}),
            _buildServiceListTile(
                3, 'Damen - Haarschnitt & Styling', '45 Min', 75, () {}),
          ],
        ),
      )
      ..add(
        _buildServiceExpansionTile(
          false,
          [4, 5, 6],
          'Alle Angebote',
          [
            _buildServiceListTile(
                4, 'Damen - Cut & Style', '45 Min', 45.0, () {}),
            _buildServiceListTile(
                5, 'Damen - Haarschnitt & Styling', '45 Min', 24.99, () {}),
            _buildServiceListTile(
                6, 'Herren - Cut & Style', '45 Min', 75, () {}),
          ],
        ),
      );

    return items;
  }

  List<int> _containsOfServices(List<int> ids) {
    List<int> contained = [];
    for (final id in ids) {
      if (_cart[id] == true) {
        contained.add(id);
      }
    }
    return contained;
  }

  Widget _buildServiceExpansionTile(bool initiallyExpanded, List<int> ids,
      String title, List<Widget> serviceListTiles) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      textColor: Colors.black,
      iconColor: Colors.black,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline6!),
          (_containsOfServices(ids).isNotEmpty)
              ? const Spacer()
              : const SizedBox(),
          (_containsOfServices(ids).isNotEmpty)
              ? Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.check,
                      color: Colors.orange,
                      size: AppFinals.iconInTextSize,
                    ),
                    const SizedBox(
                      width: AppFinals.horizontalPaddingLess,
                    ),
                    Text(
                      '${_containsOfServices(ids).length} zugefügt',
                      style: const TextStyle(
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
      children: [
        for (final w in serviceListTiles) w,
      ],
    );
  }

  HashMap<int, bool> _cart = HashMap();

  Widget _buildServiceListTile(
      int id, String title, String length, double price, Function onTap) {
    if (!_cart.containsKey(id)) {
      _cart[id] = false;
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 242, 242, 242),
      ),
      child: ListTile(
        title: Text(title),
        onTap: (() {
          setState(() {
            _cart.update(id, (value) {
              return !value;
            });
          });
        }),
        subtitle: Row(
          children: [
            TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                side: MaterialStatePropertyAll(BorderSide.none),
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: AppFinals.iconInTextSize,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: AppFinals.commonButtonDistance,
            ),
            Text(
              length,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$price €',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _cart.update(id, (value) {
                    return !value;
                  });
                });
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => RotationTransition(
                  turns: child.key == const ValueKey('icon1')
                      ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                      : Tween<double>(begin: 0.75, end: 1).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: _cart[id] == false
                    ? const Icon(
                        Icons.add_circle_outline,
                        key: ValueKey('icon1'),
                      )
                    : const Icon(
                        Icons.check_circle_outline,
                        key: ValueKey('icon2'),
                      ),
              ),
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu() => PopupMenuButton<int>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        offset: Offset(
            0, AppBar().preferredSize.height + AppFinals.verticalPadding),
        //color: Colors.grey,
        elevation: AppFinals.elevation,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: const [
                Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                Text("Get The App")
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            // row has two child icon and text
            child: Row(
              children: const [
                Icon(
                  Icons.chrome_reader_mode,
                  color: Colors.black,
                ),
                SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                Text("About")
              ],
            ),
          ),
        ],
      );

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        floating: false,
        pinned: true,
        actions: [
          _buildPopupMenu(),
        ],
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                pageSnapping: true,
                controller: _pageController,

                //itemCount: 5,
                onPageChanged: (value) => setState(
                  () {
                    //TODO if value == last image
                    if (value == 5) {
                      _pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInCirc);
                    }
                    _activePage = value;
                  },
                ),
                itemBuilder: (context, index) {
                  return Image.network(
                    _imageUrl,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.cover,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 1,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppFinals.borderRadius,
                      ),
                    ),
                    color: Colors.white38,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _indicators(5, _activePage),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  final String _imageUrl = 'https://picsum.photos/600/400';

  List<Widget> _indicators(imagesLength, currentIndex) => List<Widget>.generate(
        5,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle,
          ),
        ),
      );
}
/*Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text('Shop ID: $shopId'),
      ),
      body: Column(
        children: [
         
        ],
      ),
    );*/

/*
     Text(
            'Shop ID - ${widget.shopId}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          )
     */

class PageViewHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double appbarHeight;

  PageViewHeaderDelegate({required this.appbarHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: progress,
            child: const ColoredBox(
              color: Color(0xBE7A81FF),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: 1 - progress,
            child: Container(
              color: Colors.blue,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.lerp(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              const EdgeInsets.only(bottom: 16),
              progress,
            ),
            alignment: Alignment.lerp(
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              progress,
            ),
            child: Text(
              'Mountains',
              style: TextStyle.lerp(
                Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
                Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
                progress,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 264;

  @override
  double get minExtent => appbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
