import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/search/query_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QueryCubit extends Cubit<List<QueryModel>> {
  QueryCubit() : super([]);

  ///Returns 0 if no object is in list as first id.
  ///Returns highest id + 1 if has elements.
  int getLatestId() => state.isEmpty
      ? 0
      : state
          .map((e) => e.id)
          .reduce((current, next) => current > next ? current : next);

  int addQueryModel(QueryModel queryModel) {
    if (kDebugMode) {
      print('Add Query');
    }

    if (queryModel.id == -1) {
      //Add new query which comes from homepage. Those querys have -1 as id.
      if (kDebugMode) {
        print('Add New Query from HomePage');
      }
      final newId = (getLatestId() + 1);
      final newQuery = QueryModel(
          id: newId,
          query: queryModel.query.trim(),
          dateInMillis: queryModel.dateInMillis,
          lastModifiedInMillis: queryModel.lastModifiedInMillis,
          lat: queryModel.lat,
          lon: queryModel.lon);
      emit(List.from(state..add(newQuery)));
      return newId;
    } else if (state.any((element) => element.id == queryModel.id)) {
      //Update querymodel if exist in list
      if (kDebugMode) {
        print('Update Query, since ID exists');
      }
      updateQueryModel(queryModel);
      return queryModel.id;
    } else {
      //No action, since not a new query and ID does not exist yet
      if (kDebugMode) {
        print(
            'No action, since not a new query and ID does not exist yet. Returning -2 errorcode.');
      }
      return -2;
    }
  }

  void removeQueryModel(int id) =>
      emit(List.from(state..removeWhere((element) => element.id == id)));

  void updateQueryModel(QueryModel queryModel) {
    if (kDebugMode) {
      print('Update Query');
    }

    //Simple remove query with same id and add new object
    removeQueryModel(queryModel.id);
    emit(List.from(state..add(queryModel)));
  }

  void test() {
    print('ok');
  }

  /**
   * Modify single query model by id functions
   */

  ///This method might return null, if there is no object with given id.
  ///TODO
  QueryModel getStateById(int id) {
    if (!state.map((e) => e.id).contains(id)) {
      print('id not found in state list, should add default query?');
    }

    return state.firstWhere((element) => element.id == id);
  }

  void updateQueryById(int id, String query) {
    if (kDebugMode) {
      print('Update query');
    }

    final stateById = getStateById(id);
    final updatedQuery = stateById.copyWith(query: query.trim());
    updateQueryModel(updatedQuery);
  }

  void updateLatLonById(int id, double lat, double lon) {
    if (kDebugMode) {
      print('Update lat');
    }

    final stateById = getStateById(id);
    final updatedQuery = stateById.copyWith(lat: lat, lon: lon);
    updateQueryModel(updatedQuery);
  }

  void updateDistanceById(int id, double distance) {
    if (kDebugMode) {
      print('Update distance');
    }

    final stateById = getStateById(id);
    final updatedQuery = stateById.copyWith(distance: distance.toInt());
    updateQueryModel(updatedQuery);
  }

  void updateDateInMillisById(int id, int dateInMillis) {
    if (kDebugMode) {
      print('Update date in millis');
    }

    final stateById = getStateById(id);
    final updatedQuery = stateById.copyWith(dateInMillis: dateInMillis);
    updateQueryModel(updatedQuery);
  }

  void updateMinPriceById(int id, int minPrice) {
    if (kDebugMode) {
      print('Update last modified in millis');
    }

    final stateById = getStateById(id);
    final updatedQuery = stateById.copyWith(minPrice: minPrice);
    updateQueryModel(updatedQuery);
  }

  void updateMaxPriceById(int id, int maxPrice) {
    if (kDebugMode) {
      print('Update last modified in millis');
    }

    final stateById = getStateById(id);
    final updatedQuery = stateById.copyWith(maxPrice: maxPrice);
    updateQueryModel(updatedQuery);
  }

  void updateMinRatingById(int id, double minRating) {
    if (kDebugMode) {
      print('Update last modified in millis');
    }

    final stateById = getStateById(id);
    final updatedQuery = stateById.copyWith(minRating: minRating);
    updateQueryModel(updatedQuery);
  }
}
