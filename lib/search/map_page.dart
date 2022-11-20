import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/_logic/cubit/geo_points_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
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

class _MapPageState extends State<MapPage> {
  late osm.MapController _mapController;
  late rx.BehaviorSubject<osm.GeoPoint> _center;
  late Stream<List<DocumentSnapshot<Object?>>> _geopointsStream;

  final osm.GeoPoint _defaultCenter = osm.GeoPoint(
    latitude: 53.63681603225935,
    longitude: 9.9227556362778,
  );

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('idDebugMode: $kDebugMode');

    _mapController = osm.MapController(
      initMapWithUserPosition: kDebugMode ? false : true,
      initPosition: kDebugMode
          ? osm.GeoPoint(
              latitude: 53.63681603225935,
              longitude: 9.9227556362778,
            )
          : null,
      areaLimit: osm.BoundingBox(
        east: 5.4922941,
        north: 20.8084648,
        south: 20.817995,
        west: 2.9559113,
      ),
    );

    _center = rx.BehaviorSubject<osm.GeoPoint>.seeded(_defaultCenter);

    _geopointsStream = context.read<GeoPointsCubit>().streamGeoPoints(_center);

    //When user changes center point of map (via swiping)
    _mapController.listenerRegionIsChanging.addListener(() {
      print('region changed!');
      if (_mapController.listenerRegionIsChanging.value != null) {
        final region = _mapController.listenerRegionIsChanging.value!;
        print('center: ${region.center.latitude}, ${region.center.longitude}');

        _center.add(region.center);

        for (final gp in context.read<GeoPointsCubit>().geopoints) {
          print('x');
        }

        _mapController.setStaticPosition(
            context
                .read<GeoPointsCubit>()
                .geopoints
                .map((e) =>
                    osm.GeoPoint(latitude: e.latitude, longitude: e.longitude))
                .toList(),
            'test');
      }
    });

    /*
    //When user is taping on map
    _mapController.listenerMapSingleTapping.addListener(() {
      if (_mapController.listenerMapSingleTapping.value != null) {
        print(_mapController.listenerMapSingleTapping.value!.latitude);
        


      }

      /**
       * Load here 
       */
      _mapController.setStaticPosition([
        GeoPoint(
          latitude: 53.55574934435046,
          longitude: 9.975334883282251,
        ),
      ], 'id');
    });*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        actions: [
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
              context.read<GeoPointsCubit>().loadGeoPointsNearby(
                  currentGeoPoint.latitude, currentGeoPoint.longitude);
            },
            icon: const Icon(
              Icons.download,
            ),
          ),
        ],
      ),
      body: osm.OSMFlutter(
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
        androidHotReloadSupport: true,
        controller: _mapController,
        trackMyPosition: false,
        initZoom: 14,
        minZoomLevel: 5,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        showZoomController: true,
        showContributorBadgeForOSM: false,
        showDefaultInfoWindow: true,
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
}
