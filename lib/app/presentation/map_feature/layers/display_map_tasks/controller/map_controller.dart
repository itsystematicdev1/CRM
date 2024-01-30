import 'dart:async';
import 'package:salesman/app/presentation/map_feature/layers/display_google_maps/controller/route_controller.dart';
import 'package:salesman/app/service/network/email_sender.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../helper/log.dart';
import '../../../../../service/maps/location_service.dart';
import '../../../../../service/maps/map_service.dart';
import '../../../../../widget/snak_bar.dart';

class MapController extends GetxController implements LocationListener {
  final LocationService _locationService = LocationService();
  final EmailSenderService _emailSenderService = EmailSenderService();
  final MapService _mapService = MapService();
  late StreamController<Position> _positionStreamController;
  Rx<Position?> currentLocation = Rx<Position?>(null);
  RxBool isLocationEnabled = false.obs;
  RxBool isPermissionEnabled = false.obs;
  RxDouble startLong = 0.0.obs;
  RxDouble startLat = 0.0.obs;
  MapController get instance => Get.find();
  List<LatLng> routeCoords = [];
  Set<Polygon> polyline = {};
  Set<Marker> markers = {};
  RxBool startWork = false.obs;
  RxBool mapCreated = false.obs;
  late GoogleMapController mapController;

  @override
  void onInit() {
    Get.put(RouteController());
    _init();
    super.onInit();
    polyline.clear();
    routeCoords.clear();
    _positionStreamController = StreamController<Position>.broadcast();
    _startListening();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _init() async {
    await _locationService.getCurrentLocation(this);
    await _checkPermissionAndStartListening();
    await _checkLocationEnabled();
  }

  Future<void> _checkPermissionAndStartListening() async {
    LocationPermission? permission = await _locationService.checkPermission();

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        await _startListening();
        break;
      case LocationPermission.denied:
        await _requestPermissionAndStartListening();
        break;
      case LocationPermission.deniedForever:
        _handleDeniedForever();
        break;
      default:
        break;
    }
  }

  Future<void> _startListening() async {
    await _locationService.getCurrentLocation(this);
    _locationService.startListening(this);
    isPermissionEnabled.value = true;
    update();
  }

  Future<void> _requestPermissionAndStartListening() async {
    isPermissionEnabled.value = false;
    await _locationService.requestPermission().then((value) async {
      isPermissionEnabled.value = true;
      await _startListening();
    });
    logError('Location permission denied. Please grant permission.');
  }

  void _handleDeniedForever() {
    isPermissionEnabled.value = false;
    showCustomSnackBar(
        'Location permission permanently denied. Please enable it in App settings.');
  }

  Future<void> _checkLocationEnabled() async {
    isLocationEnabled.value = await _locationService.isLocationServiceEnabled();
    if (!isLocationEnabled.value) {
      showCustomSnackBar('Enable Location Service', isError: true);
      logError('Location service is disabled');
    }
  }

  @override
  void onLocationChanged(Position location) {
    if (!_positionStreamController.isClosed) {
      currentLocation.value = location;
      _positionStreamController.add(location);
      if (startWork.value == true) {
        logError(
            '${currentLocation.value!.latitude} : ${currentLocation.value!.longitude}');
        addToRoute();
        changeCamera(mapController);
      }
    }
  }

  Future<void> setLocValue(Position location) async {
    startLong.value = location.longitude;
    startLat.value = location.latitude;
    update();
  }

  void addToRoute() {
    if (currentLocation.value != null) {
      LatLng newLatLng = LatLng(
        currentLocation.value!.latitude,
        currentLocation.value!.longitude,
      );
      routeCoords.add(newLatLng);
      drawRoute(routeCoords.first, routeCoords.last);
      updateMark();
      update();
    }
  }

  void changeWorkSatus() {
    startWork.toggle();
    update();
  }

  void pressStopWorking() async {
    RouteController().instance.saveRouteInDB(routeCoords);
    changeWorkSatus();
  }

  void updatePolygon() {
    if (routeCoords.length >= 2) {
      polyline = _mapService.createPolyline(routeCoords);
    }
  }

  void updateMark() {
    if (markers.isEmpty) {
      markers.add(Marker(
        markerId: const MarkerId('markOne'),
        position: LatLng(
            currentLocation.value!.latitude, currentLocation.value!.longitude),
      ));
    }
  }

  void drawRoute(start, end) async {
    PointLatLng startPoint = PointLatLng(start.latitude, start.longitude);
    PointLatLng endPoint = PointLatLng(end.latitude, end.longitude);

    List<LatLng> newRouteCoords =
        await _mapService.getRouteCoordinates(startPoint, endPoint);

    if (newRouteCoords.isNotEmpty) {
      routeCoords.addAll(newRouteCoords);
      polyline = _mapService.createPolyline(routeCoords);
      updatePolygon();
      updateMark();
      update();
    }
  }

  void changeCamera(GoogleMapController mapController) async {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
              currentLocation.value!.latitude,
              currentLocation.value!.longitude,
            ),
            zoom: 16.0),
      ),
    );
  }

  void _onClose() {
    if (startWork.value == true) {
      _startListening();
    } else {
      _positionStreamController.close();
      _locationService.stopListening();
      mapCreated = false.obs;
    }
  }

  void sendEmailWithGoogleMapsLink() async {
    await _emailSenderService.sendEmailWithGoogleMapsLink(
        'abdelwahab.00964@gmail.com', routeCoords);
  }

  @override
  void onClose() {
    _onClose();
    super.onClose();
  }
}
