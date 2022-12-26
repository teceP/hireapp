import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/search/query_cubit.dart';
import 'package:autoroutetest/search/query_model.dart';
import 'package:autoroutetest/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterPage extends StatefulWidget {
  final int queryId;

  const FilterPage({required this.queryId, super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues _priceRange =
      const RangeValues(AppFinals.minPrice, AppFinals.maxPrice);
  /*DateTime? _dateTime;
  double _distance = 10;
  double _minRating = 4.5;*/

  late QueryModel _queryModel;

  final double _titleHeight = 50;
  final Color _titleColor = Colors.grey.shade200;

  @override
  void initState() {
    super.initState();

    setState(() {
      _queryModel = context.read<QueryCubit>().getStateById(widget.queryId);
    });

    /*setState(() {
      s_distance = qm.distance.toDouble();
      _minRating = qm.minRating ?? 0;
      _dateTime = DateTime.fromMillisecondsSinceEpoch(
          qm.dateInMillis ?? DateTime.now().millisecondsSinceEpoch);

      if(qm.dateInMillis != null){

      }_dateTime = Date

      if (_queryModel.minPrice != null && _queryModel.maxPrice != null) {
        _priceRange = RangeValues(
            _queryModel.minPrice!.toDouble(), _queryModel.maxPrice!.toDouble());
      } else if (_queryModel.minPrice != null && _queryModel.maxPrice == null) {
        _priceRange =
            RangeValues(_queryModel.minPrice!.toDouble(), AppFinals.maxPrice);
      } else if (_queryModel.minPrice == null && _queryModel.maxPrice != null) {
        _priceRange =
            RangeValues(AppFinals.minPrice, _queryModel.maxPrice!.toDouble());
      } else {
        _priceRange = RangeValues(AppFinals.minPrice, AppFinals.maxPrice);
      }
    });*/
    setState(() {
      setPriceRangeValues();
    });
  }

  void setPriceRangeValues() {
    if (_queryModel.minPrice != null && _queryModel.maxPrice != null) {
      _priceRange = RangeValues(
        _queryModel.minPrice!.toDouble(),
        _queryModel.maxPrice!.toDouble(),
      );
    } else if (_queryModel.minPrice != null && _queryModel.maxPrice == null) {
      _priceRange = RangeValues(
        _queryModel.minPrice!.toDouble(),
        AppFinals.maxPrice,
      );
    } else if (_queryModel.minPrice == null && _queryModel.maxPrice != null) {
      _priceRange = RangeValues(
        AppFinals.minPrice,
        _queryModel.maxPrice!.toDouble(),
      );
    } else {
      _priceRange = const RangeValues(
        AppFinals.minPrice,
        AppFinals.maxPrice,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        leading: const AutoLeadingButton(),
        actions: [
          (!_queryModel.isDefaultValued())
              ? TextButton(
                  onPressed: () => setState(() {
                    _queryModel = _queryModel.copyWithDefaultValues();
                    setPriceRangeValues();
                  }),
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Löschen',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildPriceRangeSlider(),
              _buildDateAndTime(),
              _buildDistance(),
              _buildRating(),
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomSheet(),
    );
  }

  Widget _buildTitle(String title) => Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: _titleHeight,
            width: double.infinity,
            color: _titleColor,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppFinals.horizontalPadding,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      );

  Widget _buildPriceRangeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('Preisspanne'),
        const SizedBox(
          height: AppFinals.verticalPadding,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppFinals.horizontalPadding,
          ),
          child: Row(
            children: [
              Text('${_priceRange.start.toInt()}€'),
              const Spacer(),
              Text('${_priceRange.end.toInt()}€'),
            ],
          ),
        ),
        RangeSlider(
          min: AppFinals.minPrice,
          max: AppFinals.maxPrice,
          values: _priceRange,
          onChanged: (value) => setState(() {
            _queryModel = _queryModel.copyWith(
                minPrice: value.start.toInt(), maxPrice: value.end.toInt());
            _priceRange = value;
          }),
        ),
      ],
    );
  }

  Widget _buildDateAndTime() {
    return Column(
      children: [
        _buildTitle('Datum & Uhrzeit'),
        const SizedBox(
          height: AppFinals.verticalPadding,
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
        const SizedBox(
          height: AppFinals.verticalPadding,
        ),
      ],
    );
  }

  Widget _buildDistance() {
    return Column(
      children: [
        _buildTitle('Distanz'),
        const SizedBox(
          height: AppFinals.verticalPadding,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppFinals.horizontalPadding,
          ),
          child: Row(
            children: [
              const Text('${AppFinals.minDistance} km'),
              const Spacer(),
              Text('${_queryModel.distance.toInt()} km'),
              const Spacer(),
              const Text('${AppFinals.maxDistance} km'),
            ],
          ),
        ),
        Slider(
          value: _queryModel.distance.toDouble(),
          min: AppFinals.minDistance.toDouble(),
          max: AppFinals.maxDistance.toDouble(),
          onChanged: ((value) => setState(() =>
              _queryModel = _queryModel.copyWith(distance: value.toInt()))),
        ),
        /*BlocBuilder<QueryCubit, List<QueryModel>>(
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
                      'Entfernung: ${context.watch<QueryCubit>().getStateById(widget.queryId).distance} km'),
                ],
              ),
            );
          },
        ),*/
        const SizedBox(
          height: AppFinals.verticalPadding,
        ),
      ],
    );
  }

  void showDistanceDialog() async {
    final int originalDistance =
        context.read<QueryCubit>().getStateById(widget.queryId).distance;

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Maximaler Umkreis ${context.watch<QueryCubit>().getStateById(widget.queryId).distance} km'),
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
                        .getStateById(widget.queryId)
                        .distance
                        .toDouble(),
                    onChanged: (value) =>
                        context.read<QueryCubit>().updateDistanceById(
                              widget.queryId,
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
                        widget.queryId, originalDistance.toDouble());
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
        );
      },
    );
  }

  Widget _buildDate() {
    return BlocBuilder<QueryCubit, List<QueryModel>>(
      builder: (context, state) {
        final String text;
        if (_queryModel.dateInMillis != null) {
          text = 'Datum: ${Utils.formatDate(DateTime.fromMillisecondsSinceEpoch(
            _queryModel.dateInMillis!,
          ))}';
        } else {
          text = 'Datum: irgendwann';
        }

        return TextButton(
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
                text,
              ),
            ],
          ),
        );
      },
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
      initialDate: (_queryModel.dateInMillis != null)
          ? DateTime.fromMillisecondsSinceEpoch(_queryModel.dateInMillis!)
          : DateTime.now(),
      firstDate: now,
      lastDate: lastDate,
    );

    if (chosenDateTime != null) {
      if (kDebugMode) {
        print('chosen is not null, safe to cubit');
      }
      setState(() {
        _queryModel = _queryModel.copyWith(
          dateInMillis: chosenDateTime.millisecondsSinceEpoch,
        );
      });
    }
  }

  Widget _buildTime() {
    String text;
    if (_queryModel.hour == null) {
      text = 'Uhrzeit: irgendwann';
    } else {
      text =
          'Uhrzeit: ${Utils.formatTime(Utils.buildTimeOfDay(_queryModel.hour!, _queryModel.minute))}';
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
    TimeOfDay? chosenTime = await showTimePicker(
      context: context,
      initialTime: (_queryModel.hour == null)
          ? TimeOfDay.now()
          : TimeOfDay(
              hour: _queryModel.hour!, minute: _queryModel.minute ?? 00),
    );

    if (chosenTime != null) {
      print('choosed timeofday $chosenTime');
      setState(() {
        _queryModel = _queryModel.copyWith(
          hour: chosenTime.hour,
          minute: chosenTime.minute,
        );
      });
    }
  }

  Widget _buildRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('Anbieterbewertung'),
        const SizedBox(
          height: AppFinals.verticalPadding,
        ),
        Center(
          child: RatingBar.builder(
            initialRating: _queryModel.minRating ?? 0,
            minRating: 0,
            allowHalfRating: true,
            unratedColor: Colors.amber.withAlpha(50),
            itemCount: 5,
            itemSize: 30.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            glow: false,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(
                  () => _queryModel = _queryModel.copyWith(minRating: rating));
            },
            updateOnDrag: true,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            // so here your custom shadow goes:
            BoxShadow(
              color: Colors.black
                  .withAlpha(20), // the color of a shadow, you can adjust it
              spreadRadius:
                  3, //also play with this two values to achieve your ideal result
              blurRadius: 7,
              offset: const Offset(0,
                  -7), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
            ),
          ],
        ),
        width: double.infinity,
        height: kBottomNavigationBarHeight * 2,
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppFinals.verticalPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: _queryModel.hasSameValues(
                  context.read<QueryCubit>().getStateById(widget.queryId),
                )
                    ? null
                    : () {
                        setState(
                          () {
                            setState(() {
                              _queryModel = context
                                  .read<QueryCubit>()
                                  .getStateById(widget.queryId);
                              setPriceRangeValues();
                            });
                          },
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  'Rückgängig',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  //check in new values
                  context.read<QueryCubit>().updateQueryModel(_queryModel);
                  context.router.pop();
                },
                child: const Text('Übernehmen'),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      );
}
