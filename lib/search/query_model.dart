import 'package:autoroutetest/app_finals.dart';
import 'package:equatable/equatable.dart';

class QueryModel extends Equatable {
  final int id;
  final String query;
  final int? dateInMillis;
  final int? hour, minute;
  final int lastModifiedInMillis;
  final double lat;
  final double lon;
  final int distance;
  final int? maxPrice, minPrice;
  final double? minRating;

  const QueryModel({
    required this.id,
    required this.query,
    required this.lastModifiedInMillis,
    required this.lat,
    required this.lon,
    this.dateInMillis,
    this.hour,
    this.minute,
    this.distance = AppFinals.defaultDistance,
    this.maxPrice,
    this.minPrice,
    this.minRating,
  });

  QueryModel copyWith(
          {int? id,
          String? query,
          int? dateInMillis,
          double? lat,
          double? lon,
          int? hour,
          int? minute,
          int? distance,
          int? maxPrice,
          int? minPrice,
          double? minRating}) =>
      QueryModel(
        id: id ?? this.id,
        query: query ?? this.query,
        dateInMillis: dateInMillis ?? this.dateInMillis,
        lastModifiedInMillis: DateTime.now().millisecondsSinceEpoch,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        distance: distance ?? this.distance,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        minRating: minRating ?? this.minRating,
      );

  QueryModel copyWithNullDateInMillis(
          {int? id,
          String? query,
          int? dateInMillis,
          double? lat,
          double? lon,
          int? hour,
          int? minute,
          int? distance,
          int? maxPrice,
          int? minPrice,
          double? minRating}) =>
      QueryModel(
        id: id ?? this.id,
        query: query ?? this.query,
        dateInMillis: dateInMillis,
        lastModifiedInMillis: DateTime.now().millisecondsSinceEpoch,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        distance: distance ?? this.distance,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        minRating: minRating ?? this.minRating,
      );

  bool isDefaultValued() =>
      dateInMillis == null &&
      hour == null &&
      minute == null &&
      maxPrice == null &&
      minPrice == null &&
      minRating == null;

  QueryModel copyWithDefaultValues() => QueryModel(
        id: id,
        query: query,
        lastModifiedInMillis: DateTime.now().millisecondsSinceEpoch,
        lat: lat,
        lon: lon,
      );

  bool hasSameValues(QueryModel other) =>
      id == other.id &&
      query == other.query &&
      dateInMillis == other.dateInMillis &&
      distance == other.distance &&
      hour == other.hour &&
      minute == other.minute &&
      lat == other.lat &&
      lon == other.lon &&
      maxPrice == other.maxPrice &&
      minPrice == other.minPrice &&
      minRating == other.minRating;

  @override
  List<Object?> get props => [
        id,
        query,
        dateInMillis,
        lastModifiedInMillis,
        hour,
        minute,
        lat,
        lon,
        distance,
        maxPrice,
        minPrice,
        minRating,
      ];
}
