import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/search/filter_page.dart';
import 'package:autoroutetest/search/query_cubit.dart';
import 'package:autoroutetest/search/query_model.dart';
import 'package:autoroutetest/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  int id;

  SearchPage({
    @QueryParam('id') this.id = 0,
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late MapController _mapController;
  late OverlayEntry _popupDialog;
  final TextEditingController _textEditingController = TextEditingController();
  late final AnimationController _animationController;
  late final _animation;
  final double kChipHeight = 35;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animation = Tween(begin: 0, end: 2 * pi).animate(_animationController);
    _textEditingController.text =
        context.read<QueryCubit>().getStateById(widget.id).query;
  }

  @override
  Widget build(BuildContext context) {
    final int len = context.read<QueryCubit>().state.length;
    final bool hasDeliveredId =
        context.read<QueryCubit>().state.map((e) => e.id).contains(widget.id);
    print('query cubit length: $len');
    print('query cubit has delivered id (${widget.id}): $hasDeliveredId');

    return BlocBuilder<QueryCubit, List<QueryModel>>(
      builder: (context, queryListState) {
        return Material(
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: _buildActiveFilterChips(),
                ),
                SliverFillRemaining(
                  child: _buildSuggestions(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        leading: const AutoLeadingButton(),
        title: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'Suche',
            fillColor: Colors.white,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppFinals.borderRadiusTextField,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppFinals.horizontalPaddingTextField,
                vertical: AppFinals.verticalPaddingTextField),
            filled: true,
          ),
          onChanged: (value) {
            print(value);
            context.read<QueryCubit>().updateQueryById(widget.id, value);
          },
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () => context.router.push(
                  FilterRouter(queryId: widget.id),
                ),
                icon: const Icon(
                  Icons.filter_list,
                ),
              ),
              Positioned(
                right: 6,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: context
                            .read<QueryCubit>()
                            .getStateById(widget.id)
                            .isDefaultValued()
                        ? Colors.transparent
                        : Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    minHeight: 10,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              context.router.push(
                const MapRouter(),
              );
            },
            icon: const Icon(
              Icons.map,
            ),
          ),
        ],
      );

  Widget _buildActiveFilterChips() {
    final activeFilterChips = [
      Chip(
        onDeleted: () {
          return;
        },
        label: Text(
            '${context.read<QueryCubit>().getStateById(widget.id).distance} km'),
      ),
      Chip(
        onDeleted: () {
          return;
        },
        label: Text('4.5 Bewertung'),
      ),
      Chip(
        onDeleted: () {
          return;
        },
        label: Text('Bis 35€'),
      ),
      Chip(
        onDeleted: () {
          return;
        },
        label: Text('Ab 10€'),
      ),
    ];

    return Container(
      padding: const EdgeInsets.only(
        top: AppFinals.verticalPadding,
        bottom: AppFinals.verticalPadding - 7,
      ),
      height: kChipHeight +
          (AppFinals.verticalPadding + AppFinals.verticalPadding - 7),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: activeFilterChips.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: AppFinals.horizontalPaddingLess,
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: AppFinals.horizontalPaddingLess),
        itemBuilder: (context, index) => activeFilterChips[index],
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.separated(
      padding: const EdgeInsets.only(
        left: AppFinals.horizontalPaddingLess,
        right: AppFinals.horizontalPaddingLess,
        top: AppFinals.verticalPaddingAdditional,
        bottom: AppFinals.bottomSafeAreaPadding,
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppFinals.commonWidgetDistance),
      itemCount: TabBarData.animals.length,
      itemBuilder: (context, index) => PreviewCard(
        item: TabBarData.animals[index],
        shopId: '54321',
        height: Utils.h(context) * 0.3,
        tabBarDataIndex: index,
      ),
    );
  }
}
