import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteData {
  List<LatLng> route;

  RouteData({
    required this.route,
  });

  factory RouteData.fromJson(Map<String, dynamic> json) {
    return RouteData(
      route: (json['route'] as List<dynamic>)
          .map((latLngJson) => LatLng(
                latLngJson['latitude'] ?? 0.0,
                latLngJson['longitude'] ?? 0.0,
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'route': route.map((latLng) => {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      }).toList(),
    };
  }
}
