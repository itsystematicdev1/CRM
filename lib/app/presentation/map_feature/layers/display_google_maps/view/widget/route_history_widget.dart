import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salesman/app/presentation/map_feature/layers/display_google_maps/controller/route_controller.dart';
import 'package:salesman/app/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteHistory extends StatelessWidget {
  const RouteHistory(
      {super.key,
      required this.controller,
      required this.title,
      required this.routePoints});
  final RouteController controller;
  final String title;
  final List<GeoPoint> routePoints;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            controller.routePoints.first.latitude,
            controller.routePoints.first.longitude,
          ),
          zoom: 12,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        mapToolbarEnabled: true,
        onMapCreated: (GoogleMapController controller) {},
        markers: {
          Marker(
            markerId: const MarkerId('markOne'),
            position: LatLng(
              controller.routePoints.first.latitude,
              controller.routePoints.first.longitude,
            ),
          ),
          Marker(
            markerId: const MarkerId('markTwo'),
            position: LatLng(
              controller.routePoints.last.latitude,
              controller.routePoints.last.longitude,
            ),
          )
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('historyroute'),
            points: routePoints
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
            color: Colors.redAccent.shade700,
            width: 3,
          ),
        },
      ),
    );
  }
}
