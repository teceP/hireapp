import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/home/tabbar/home_page_tab.dart';
import 'package:autoroutetest/home/tabbar/tab_bar_data.dart';
import 'package:autoroutetest/routes/router.gr.dart';
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
            appBar: _buildAppBar(),
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

  AppBar _buildAppBar() => AppBar(
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
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                useSafeArea: false,
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Filter'),
                      leading: const AutoLeadingButton(),
                    ),
                    body: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: AppFinals.horizontalPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildDate(),
                              const SizedBox(
                                width: AppFinals.verticalPadding,
                              ),
                              _buildTime(),
                            ],
                          ),
                          _buildDistance(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.filter_list,
            ),
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

  Widget _buildDistance() {
    return BlocBuilder<QueryCubit, List<QueryModel>>(
      builder: (context, queryModelList) {
        return TextButton(
          onPressed: showDistanceDialog,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.route,
              ),
              Text(
                  'Entfernung: ${context.watch<QueryCubit>().getStateById(widget.id).distance} km'),
            ],
          ),
        );
      },
    );
  }

  void showDistanceDialog() async {
    final int originalDistance =
        context.read<QueryCubit>().getStateById(widget.id).distance;

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Maximaler Umkreis ${context.watch<QueryCubit>().getStateById(widget.id).distance} km'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: AppFinals.horizontalPadding,
                  ),
                  const Text('${AppFinals.minDistance}'),
                  Expanded(
                    child: Slider(
                      min: AppFinals.minDistance.toDouble(),
                      max: AppFinals.maxDistance.toDouble(),
                      value: context
                          .watch<QueryCubit>()
                          .getStateById(widget.id)
                          .distance
                          .toDouble(),
                      onChanged: (value) =>
                          context.read<QueryCubit>().updateDistanceById(
                                widget.id,
                                value,
                              ),
                    ),
                  ),
                  const Text('${AppFinals.maxDistance}'),
                  const SizedBox(
                    width: AppFinals.horizontalPadding,
                  ),
                ],
              ),
              const SizedBox(
                height: AppFinals.commonWidgetDistance,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<QueryCubit>().updateDistanceById(
                          widget.id, originalDistance.toDouble());
                      context.router.pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100),
                    child: const Text(
                      'Abbrechen',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: AppFinals.commonButtonDistance,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    child: const Text('OK '),
                  ),
                  const SizedBox(
                    width: AppFinals.horizontalPadding,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDate() {
    return BlocBuilder<QueryCubit, List<QueryModel>>(
      builder: (context, state) => TextButton(
        onPressed: showDatePickerDialog,
        child: Row(
          children: [
            const Icon(
              FontAwesomeIcons.calendar,
              size: AppFinals.iconInTextSize,
            ),
            const SizedBox(
              width: AppFinals.paddingInText,
            ),
            Text(
              'Datum: ${Utils.formatDate(DateTime.fromMillisecondsSinceEpoch(
                context
                    .watch<QueryCubit>()
                    .getStateById(widget.id)
                    .dateInMillis,
              ))}',
            ),
          ],
        ),
      ),
    );
  }

  void showDatePickerDialog() async {
    DateTime now = DateTime.now();

    final lastDate = now.add(
      const Duration(
        days: 365,
      ),
    );

    final DateTime? chosenDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(
        context.read<QueryCubit>().getStateById(widget.id).dateInMillis,
      ),
      firstDate: now,
      lastDate: lastDate,
    );

    if (chosenDateTime != null) {
      if (kDebugMode) {
        print('chosen is not null, safe to cubit');
      }
      context.read<QueryCubit>().updateDateInMillisById(
          widget.id, chosenDateTime.millisecondsSinceEpoch);
    }
  }

  Widget _buildTime() {
    final DateTime currentChosenDate = DateTime.fromMillisecondsSinceEpoch(
        context.read<QueryCubit>().getStateById(widget.id).dateInMillis);

    final bool isChosenDateToday = Utils.isDateToday(currentChosenDate);
    final bool isChosenDateZeroTime =
        Utils.isChosenDateZeroTime(currentChosenDate);

    //final bool shouldBeAnyTime = !isChosenDateToday && isChosenDateZeroTime;

    String text;
    if (isChosenDateZeroTime) {
      text = 'Uhrzeit: Ganzer Tag';
    } else {
      text = 'Uhrzeit: ${Utils.formatTime(currentChosenDate)}';
    }

    return BlocBuilder<QueryCubit, List<QueryModel>>(
      builder: (context, state) {
        return TextButton(
          onPressed: showTimePickerDialog,
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.clock,
                size: AppFinals.iconInTextSize,
              ),
              const SizedBox(
                width: AppFinals.paddingInText,
              ),
              Text(
                text,
              ),
            ],
          ),
        );
      },
    );
  }

  void showTimePickerDialog() async {
    final DateTime currentChosenDate = DateTime.fromMillisecondsSinceEpoch(
        context.read<QueryCubit>().getStateById(widget.id).dateInMillis);

    final bool isChosenDateZeroTime =
        Utils.isChosenDateZeroTime(currentChosenDate);

    TimeOfDay? chosenTime = await showTimePicker(
      context: context,
      initialTime: isChosenDateZeroTime
          ? TimeOfDay.now()
          : TimeOfDay.fromDateTime(
              DateTime.fromMillisecondsSinceEpoch(
                context.read<QueryCubit>().getStateById(widget.id).dateInMillis,
              ),
            ),
    );

    if (chosenTime != null) {
      print('choosed timeofday $chosenTime');

      final DateTime originChosen = DateTime.fromMillisecondsSinceEpoch(
          context.read<QueryCubit>().getStateById(widget.id).dateInMillis);

      final DateTime newChosen = DateTime(
        originChosen.year,
        originChosen.month,
        originChosen.day,
        chosenTime.hour,
        chosenTime.minute,
      );

      context
          .read<QueryCubit>()
          .updateDateInMillisById(widget.id, newChosen.millisecondsSinceEpoch);
    }
  }

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
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: AppFinals.horizontalPaddingLess,
        right: AppFinals.horizontalPaddingLess,
        bottom: 10,
      ),
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
