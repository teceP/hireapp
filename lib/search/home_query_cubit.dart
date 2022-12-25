import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/search/query_cubit.dart';
import 'package:autoroutetest/search/query_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeQueryCubit extends Cubit<QueryModel> {
  HomeQueryCubit()
      : super(
          QueryModel(
            id: -1,
            query: '',
            dateInMillis: DateTime.now().millisecondsSinceEpoch,
            lastModifiedInMillis: DateTime.now().millisecondsSinceEpoch,
            distance: AppFinals.defaultDistance,
            lat: 53.565060266997044,
            lon: 9.978092596144872,
          ),
        );

  void updateQuery(String query) {
    if (kDebugMode) {
      print('Update query');
    }

    final newQuery = state.copyWith(query: query);
    emit(newQuery);
  }

  void updateLatLon(double lat, double lon) {
    if (kDebugMode) {
      print('Update lat');
    }

    final newQuery = state.copyWith(lat: lat, lon: lon);
    emit(newQuery);
  }

  void updateDistance(double distance) {
    if (kDebugMode) {
      print('Update distance');
    }

    final newQuery = state.copyWith(distance: distance.toInt());
    emit(newQuery);
  }

  void updateDateInMillis(int dateInMillis) {
    if (kDebugMode) {
      print('Update date in millis');
    }

    final newQuery = state.copyWith(dateInMillis: dateInMillis);
    emit(newQuery);
  }

  void backToDefault() {
    emit(QueryModel(
      id: -1,
      query: '',
      dateInMillis: DateTime.now().millisecondsSinceEpoch,
      lastModifiedInMillis: DateTime.now().millisecondsSinceEpoch,
      distance: AppFinals.defaultDistance,
      lat: 53.565060266997044,
      lon: 9.978092596144872,
    ));
  }
}
