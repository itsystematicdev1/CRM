import 'dart:async';
import 'package:salesman/app/helper/log.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationListener {
  void onLocationChanged(Position location);
}

class LocationService {
  Position? currentLocation;
  late StreamSubscription<Position> positionStreamSubscription;

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission?> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<void> requestPermission() async {
    try {
      await Geolocator.requestPermission();
    } catch (e) {
      // Handle the case where the user denied permission
      logError('Permission denied: $e');
    }
  }

  Future<void> getCurrentLocation(LocationListener listener) async {
    if (await isLocationServiceEnabled()) {
      await requestPermission(); // Request permission before getting the location
      currentLocation = await Geolocator.getCurrentPosition();

      listener.onLocationChanged(currentLocation!);
    }
  }

  Future<void> updateLocation(LocationListener listener) async {
    getCurrentLocation(listener);
  }

  void startListening(LocationListener listener) {
    positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentLocation = position;
      listener.onLocationChanged(currentLocation!);
    });
  }

  void stopListening() {
    positionStreamSubscription.cancel();
  }
}
