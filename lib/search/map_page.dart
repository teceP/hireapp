import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/_logic/cubit/geo_points_cubit.dart';
import 'package:autoroutetest/search/search_finals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:loading_animations/loading_animations.dart';
import 'dart:convert';
import 'package:rxdart/rxdart.dart' as rx;

import 'package:rxdart/subjects.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  final osm.MapController _mapController = osm.MapController(
    initMapWithUserPosition:
        !kDebugMode, //TODO: this might be false, if user searched for specific location
    initPosition: kDebugMode
        ? osm.GeoPoint(
            latitude: 53.63681603225935,
            longitude: 9.9227556362778,
          ) //TODO: this might be true, if user searched for specific location

        : null,
    areaLimit: osm.BoundingBox(
      east: 5.4922941,
      north: 20.8084648,
      south: 20.817995,
      west: 2.9559113,
    ),
  );
  late rx.BehaviorSubject<osm.GeoPoint> _center;
  late Stream<List<DocumentSnapshot<Object?>>> _geopointsStream;

  final osm.GeoPoint _defaultCenter = osm.GeoPoint(
    latitude: 53.63681603225935,
    longitude: 9.9227556362778,
  );

  late osm.GeoPoint _userLocation;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _center = rx.BehaviorSubject<osm.GeoPoint>.seeded(_defaultCenter);
    _geopointsStream = context.read<GeoPointsCubit>().streamGeoPoints(_center);
  }

  void _setClickedListener(BuildContext context) {
    _mapController.listenerMapSingleTapping.addListener(() {
      if (_mapController.listenerMapSingleTapping.value != null) {
        final singleTapGeoPoint =
            _mapController.listenerMapSingleTapping.value!;
        print('Single Tap: ${singleTapGeoPoint.toString()}');
      }
    });
  }

  void _setRegionChangingListener(BuildContext context) {
//When user changes center point of map (via swiping)
    _mapController.listenerRegionIsChanging.addListener(() async {
      print('region changed!');
      if (_mapController.listenerRegionIsChanging.value != null) {
        final region = _mapController.listenerRegionIsChanging.value!;
        print('center: ${region.center.latitude}, ${region.center.longitude}');

        _center.add(region.center);

        final List<osm.GeoPoint> staticGeoPointsNearby = await context
            .read<GeoPointsCubit>()
            .staticGeoPointsNearby(region, 2000);

        print('size: ${staticGeoPointsNearby.length}');

        if (staticGeoPointsNearby != null && staticGeoPointsNearby.isNotEmpty) {
          _mapController.setStaticPosition(
            staticGeoPointsNearby,
            SearchFinals.locationDynamics,
          );
        }
      }
    });
  }

  void _onGpsFixed(BuildContext context, bool setMarker) async {
    _userLocation = await _mapController.myLocation();
    _mapController.goToLocation(_userLocation);

    if (setMarker) {
      _mapController.setStaticPosition(
        <osm.GeoPoint>[_userLocation],
        SearchFinals.locationUser,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        actions: [
          IconButton(
            onPressed: () => _onGpsFixed(context, false),
            icon: const Icon(
              Icons.gps_fixed,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<GeoPointsCubit>().uploadPoints();
            },
            icon: const Icon(
              Icons.upload,
            ),
          ),
          IconButton(
            onPressed: () async {
              print('Curren location');
              osm.GeoPoint currentGeoPoint = await _mapController.myLocation();
              print('Curren location');
              if (mounted) {
                context.read<GeoPointsCubit>().loadGeoPointsNearby(
                    currentGeoPoint.latitude, currentGeoPoint.longitude);
              }
            },
            icon: const Icon(
              Icons.download,
            ),
          ),
        ],
      ),
      body: osm.OSMFlutter(
        onMapIsReady: (isMapReady) {
          print('isMapReady: ${isMapReady}');

          if (isMapReady) {
            _onGpsFixed(context, true);
            _setRegionChangingListener(context);
            _setClickedListener(context);
          }
        },
        onGeoPointClicked: (p0) {
          print('GeoPoint clicked!');
        },
        mapIsLoading: Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: LoadingBouncingGrid.square(
              backgroundColor: Colors.green,
            ),
          ),
        ),
        androidHotReloadSupport: kDebugMode,
        controller: _mapController,
        trackMyPosition: false,
        initZoom: 14,
        minZoomLevel: 5,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        isPicker: false,
        showZoomController: true,
        showContributorBadgeForOSM: false,
        showDefaultInfoWindow: false,
        staticPoints: [
          osm.StaticPositionGeoPoint(
            SearchFinals.locationUser,
            const osm.MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                size: 48,
                color: Colors.red,
              ),
            ),
            <osm.GeoPoint>[],
          ),
          osm.StaticPositionGeoPoint(
            SearchFinals.locationDynamics,
            const osm.MarkerIcon(
              icon: Icon(
                Icons.pin_drop,
                size: 48,
                color: Colors.green,
              ),
            ),
            <osm.GeoPoint>[],
          ),
        ],
        userLocationMarker: osm.UserLocationMaker(
          personMarker: const osm.MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.green,
              size: 58,
            ),
          ),
          directionArrowMarker: const osm.MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: osm.RoadConfiguration(
          startIcon: const osm.MarkerIcon(
            icon: Icon(
              Icons.person,
              size: 64,
              color: Colors.brown,
            ),
          ),
          roadColor: Colors.yellowAccent,
        ),
        markerOption: osm.MarkerOption(
          defaultMarker: const osm.MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
