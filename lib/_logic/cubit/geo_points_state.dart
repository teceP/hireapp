part of 'geo_points_cubit.dart';

@immutable
abstract class GeoPointsState {}

class GeoPointsInitial extends GeoPointsState {}

class GeoPointsLoading extends GeoPointsState {}

class GeoPointsLoadedWithResults extends GeoPointsState {}

class GeoPointsLoadedWithoutResults extends GeoPointsState {}