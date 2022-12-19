import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;

class SearchModel {
  String service = 'Friseur';

  String address = 'Lohmühlenstraße 40, 12435';

  osm.GeoPoint addressLatLong =
      osm.GeoPoint(latitude: 12.3456, longitude: 65.4321);

  int distance = 20;

  DateTime dateTime = DateTime.now();
}
