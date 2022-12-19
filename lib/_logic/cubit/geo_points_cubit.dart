import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart' as rx;

part 'geo_points_state.dart';

class GeoPointsCubit extends Cubit<GeoPointsState> {
  final geo = GeoFlutterFire();
  final _firestore = FirebaseFirestore.instance;
  final List<GeoFirePoint> _geopoints = [
    GeoFirePoint(53.63722283559534, 9.916662224838287),
    GeoFirePoint(53.63773206234641, 9.922669884282625),
    GeoFirePoint(53.64210776237749, 9.915287199934266),
    GeoFirePoint(53.630758530066714, 9.905335741989019),
    GeoFirePoint(37.79702552606294, -122.40384207935548),
    GeoFirePoint(37.800586111975896, -122.42066489448885),
    GeoFirePoint(37.777286602471456, -122.41285430188543),
    GeoFirePoint(37.785257420902916, -122.39577399474244),
  ];

  GeoPointsCubit() : super(GeoPointsInitial());

  Future<List<osm.GeoPoint>> staticGeoPointsNearby(
      osm.Region region, double maxDistance) async {
    List<osm.GeoPoint> nearby = [];

    for (GeoFirePoint geoFirePoint in _geopoints) {
      final osm.GeoPoint geoPoint = osm.GeoPoint(
          latitude: geoFirePoint.latitude, longitude: geoFirePoint.longitude);

      final distance = await osm.distance2point(geoPoint, region.center);
      print('distance: $distance, maxDistance: $maxDistance');
      if (distance < maxDistance) {
        nearby.add(geoPoint);
        print('added');
      }
    }

    return nearby;
  }

  List<osm.GeoPoint> parseGeoFirePoints(List<GeoFirePoint> geoFirePoints) {
    return geoFirePoints
        .map((e) => osm.GeoPoint(latitude: e.latitude, longitude: e.longitude))
        .toList();
  }

  /**
   * Parameter should be current map position
   */
  Stream<List<DocumentSnapshot>> streamGeoPoints(
      rx.BehaviorSubject<osm.GeoPoint> centerBehaviorSubject) {
    //GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);
    final collectionReference = _firestore.collection('locations');
    final String field = 'position';

    print('rx!');

    //TODO: change radius on user zooming

    centerBehaviorSubject
        .switchMap(
      (center) => geo.collection(collectionRef: collectionReference).within(
            center: GeoFirePoint(center.latitude, center.longitude),
            radius: 1234, //region.boundingbox.north+south
            field: field,
          ),
    )
        .transform(
      StreamTransformer.fromHandlers(
        handleData: (docSnaps, sink) {
          print('doc size: ${docSnaps.length}');
          if (docSnaps.isNotEmpty) {
            for (final doc in docSnaps) {
              print('doc: ${doc.metadata}');
              //sink.add(docSnaps)
            }
          }
        },
      ),
    );

    return centerBehaviorSubject.switchMap(
      (center) => geo.collection(collectionRef: collectionReference).within(
            center: GeoFirePoint(center.latitude, center.longitude),
            radius: 1234, //region.boundingbox.north+south
            field: field,
          ),
    );
  }

  Future<List<GeoFirePoint>> loadGeoPointsNearby(
      double latitude, double longitude) async {
    print('loadGeoPointsNearby');

    emit(GeoPointsLoading());

    final usersGeoPoint = GeoFirePoint(latitude, longitude);
    final List<GeoFirePoint> nearbyGeoPoints =
        List.from(_geopoints); //TODO load here from firestore

    final collectionReference = _firestore.collection('location');
    const String field = 'position';

    final Stream<List<DocumentSnapshot>> stream =
        geo.collection(collectionRef: collectionReference).within(
              center: usersGeoPoint,
              radius: 1234, //region.boundingbox.north+south
              field: field,
            );
    stream.listen((event) {
      event.forEach((element) {
        print(element.data()!);
      });
    });
    emit(nearbyGeoPoints.isEmpty
        ? GeoPointsLoadedWithoutResults()
        : GeoPointsLoadedWithResults());
    return nearbyGeoPoints;
  }

  void uploadPoints() {
    if (kDebugMode) {
      print('uploadPoints');
      print('geoPoints size: ${_geopoints.length}');
    }

    for (var geopoint in _geopoints) {
      _firestore.collection('locations').add(
        {'name': 'random name', 'position': geopoint.data},
      );
    }
  }
}
