import 'package:salesman/app/helper/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../helper/strings.dart';

class MapService {
  final PolylinePoints polylinePoints = PolylinePoints();

  Future<List<LatLng>> getRouteCoordinates(
      PointLatLng startPoint, PointLatLng endPoint) async {
    List<LatLng> routeCoords = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapKey,
      startPoint,
      endPoint,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        routeCoords.add(LatLng(point.latitude, point.longitude));
      }
    }

    return routeCoords;
  }

  Set<Polygon> createPolyline(List<LatLng> routeCoords) {
    Set<Polygon> polyline = {};

    if (routeCoords.length >= 2) {
      polyline.add(
        Polygon(
          polygonId: const PolygonId("fullRoute"),
          points: routeCoords,
          strokeWidth: 3,
          strokeColor: Colors.redAccent.shade700,
          fillColor: Colors.transparent,
        ),
      );
    }

    return polyline;
  }

  Future<Map<String, dynamic>> getDirections(LatLng start, LatLng end) async {
    final String origin = '${start.latitude},${start.longitude}';
    final String destination = '${end.latitude},${end.longitude}';

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$googleMapKey';

    try {
      var response = await http.get(Uri.parse(url));
      var json = convert.jsonDecode(response.body);

      var results = {
        'bounds_ne': json['routes'][0]['bounds']['northeast'],
        'bounds_sw': json['routes'][0]['bounds']['southwest'],
        'start_location': json['routes'][0]['legs'][0]['start_location'],
        'end_location': json['routes'][0]['legs'][0]['end_location'],
        'polyline': json['routes'][0]['overview_polyline']['points'],
        'polyline_decoded': PolylinePoints()
            .decodePolyline(json['routes'][0]['overview_polyline']['points'])
            .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
            .toList(),
      };

      logError('the result from map Service is $results');

      return results;
    } catch (e) {
      logError('Error getting directions: $e');
      return {};
    }
  }
}
