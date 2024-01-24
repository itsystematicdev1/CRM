import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteOptimizationService {
  // calculate the distance between two LatLng points
  double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers
    double lat1 = point1.latitude * (pi / 180.0);
    double lon1 = point1.longitude * (pi / 180.0);
    double lat2 = point2.latitude * (pi / 180.0);
    double lon2 = point2.longitude * (pi / 180.0);

    double dlon = lon2 - lon1;
    double dlat = lat2 - lat1;

    double a = pow(sin(dlat / 2), 2) +
        cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c; // Distance in kilometers
    return distance;
  }

  // find the nearest unvisited point
  LatLng findNearestPoint(LatLng currentPoint, List<LatLng> unvisitedPoints) {
    double minDistance = double.infinity;
    LatLng nearestPoint = unvisitedPoints.first;

    for (LatLng point in unvisitedPoints) {
      double distance = calculateDistance(currentPoint, point);
      if (distance < minDistance) {
        minDistance = distance;
        nearestPoint = point;
      }
    }

    return nearestPoint;
  }

  // optimize the route using the nearest neighbor algorithm
  List<LatLng> optimizeRoute(List<LatLng> points) {
    List<LatLng> optimizedRoute = [];
    List<LatLng> unvisitedPoints = List.from(points);

    // Start from a random point
    LatLng currentPoint = unvisitedPoints.removeAt(Random().nextInt(unvisitedPoints.length));
    optimizedRoute.add(currentPoint);

    // Find the nearest unvisited point iteratively
    while (unvisitedPoints.isNotEmpty) {
      LatLng nearestPoint = findNearestPoint(currentPoint, unvisitedPoints);
      optimizedRoute.add(nearestPoint);
      currentPoint = unvisitedPoints.removeAt(unvisitedPoints.indexOf(nearestPoint));
    }

    return optimizedRoute;
  }
}
