import 'package:autoroutetest/app_finals.dart';
import 'package:equatable/equatable.dart';

class QueryModel extends Equatable {
  final int id;
  final String query;
  final int dateInMillis;
  final int lastModifiedInMillis;
  final double lat;
  final double lon;
  final int distance;
  final int? maxPrice, minPrice;
  final double? minRating;

  const QueryModel({
    required this.id,
    required this.query,
    required this.dateInMillis,
    required this.lastModifiedInMillis,
    required this.lat,
    required this.lon,
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
          int? distance,
          int? maxPrice,
          int? minPrice,
          double? minRating}) =>
      QueryModel(
        id: id ?? this.id,
        query: query ?? this.query,
        dateInMillis: dateInMillis ?? this.dateInMillis,
        lastModifiedInMillis: DateTime.now().millisecondsSinceEpoch,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        minRating: minRating ?? this.minRating,
      );

  @override
  List<Object?> get props => [
        id,
        query,
        dateInMillis,
        lastModifiedInMillis,
        lat,
        lon,
        distance,
        maxPrice,
        minPrice,
        minRating,
      ];
}
