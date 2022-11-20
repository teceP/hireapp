import 'dart:async';

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
  List<GeoFirePoint> geopoints = [];
  final double maxDistance = 200000000;

  GeoPointsCubit() : super(GeoPointsInitial());

  void loadGeoPoints() {
    geopoints = [
      GeoFirePoint(
        53.63722283559534,
        9.916662224838287,
      ),
      GeoFirePoint(
        53.63773206234641,
        9.922669884282625,
      ),
      GeoFirePoint(
        53.64210776237749,
        9.915287199934266,
      ),
      GeoFirePoint(
        53.630758530066714,
        9.905335741989019,
      ),
    ];
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
            radius: maxDistance,
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

    _tempAddDummpy();

    return centerBehaviorSubject.switchMap(
      (center) => geo.collection(collectionRef: collectionReference).within(
            center: GeoFirePoint(center.latitude, center.longitude),
            radius: maxDistance,
            field: field,
          ),
    );
  }

  void _tempAddDummpy() {
    geopoints.addAll(
      [
        GeoFirePoint(
          53.63722283559534,
          9.916662224838287,
        ),
        GeoFirePoint(
          53.63773206234641,
          9.922669884282625,
        ),
        GeoFirePoint(
          53.64210776237749,
          9.915287199934266,
        ),
        GeoFirePoint(
          53.630758530066714,
          9.905335741989019,
        ),
      ],
    );
  }

  Future<List<GeoFirePoint>> loadGeoPointsNearby(
      double latitude, double longitude) async {
    print('loadGeoPointsNearby');

    if (geopoints.isEmpty) {
      emit(GeoPointsLoading());
      loadGeoPoints();
    }
    final usersGeoPoint = GeoFirePoint(latitude, longitude);
    final List<GeoFirePoint> nearbyGeoPoints = [];

    final collectionReference = _firestore.collection('location');
    const String field = 'position';

    final Stream<List<DocumentSnapshot>> stream =
        geo.collection(collectionRef: collectionReference).within(
              center: usersGeoPoint,
              radius: maxDistance,
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
    if (geopoints.isEmpty) {
      loadGeoPoints();
    }

    if (kDebugMode) {
      print('uploadPoints');
      print('geoPoints size: ${geopoints.length}');
    }

    for (var geopoint in geopoints) {
      _firestore.collection('locations').add(
        {'name': 'random name', 'position': geopoint.data},
      );
    }
  }

  /*void loadGeoPoints() {
    geopoints = [
      osm.GeoPoint(
        latitude: 53.63722283559534,
        longitude: 9.916662224838287,
      ),
      osm.GeoPoint(
        latitude: 53.63773206234641,
        longitude: 9.922669884282625,
      ),
      osm.GeoPoint(
        latitude: 53.64210776237749,
        longitude: 9.915287199934266,
      ),
      osm.GeoPoint(
        latitude: 53.630758530066714,
        longitude: 9.905335741989019,
      ),
    ];
  }

  Future<List<osm.GeoPoint>> loadGeoPointsNearby(
      double latitude, double longitude) async {
    if (geopoints.isEmpty) {
      emit(GeoPointsLoading());
      loadGeoPoints();
    }
    final usersGeoPoint = osm.GeoPoint(latitude: latitude, longitude: longitude);
    final List<osm.GeoPoint> nearbyGeoPoints = [];

    for (final gp in geopoints) {
      final distance = await osm.distance2point(gp, usersGeoPoint);
      if (distance < maxDistance) {
        nearbyGeoPoints.add(gp);
      }
    }

    emit(nearbyGeoPoints.isEmpty
        ? GeoPointsLoadedWithoutResults()
        : GeoPointsLoadedWithResults());
    return nearbyGeoPoints;
  }*/
}
