import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../display_map_tasks/controller/map_controller.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    required this.controller,
    required this.markers,
    required this.route,
  });
  final Set<Marker> markers;
  final Set<Polyline> route;
  final MapController controller;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Obx(
        () {
          final currentLocation = widget.controller.currentLocation.value;

          if (currentLocation != null ) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(currentLocation.latitude, currentLocation.longitude),
                zoom: 12,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              mapToolbarEnabled: true,
              onMapCreated: (GoogleMapController gcontroller) {
               widget.controller.mapController = gcontroller;
              },
              markers: widget.markers,
              polylines: widget.route
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
          
        },
      ),
    );
  }
  
}
