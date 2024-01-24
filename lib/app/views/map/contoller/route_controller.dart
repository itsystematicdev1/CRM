import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salesman/app/service/network/firebase/map_service.dart';
import 'package:salesman/app/widget/snak_bar.dart';
import 'package:salesman/app/helper/log.dart';
import 'package:salesman/app/helper/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../service/network/firebase/firebase_map_service.dart';
import '../../../service/network/firebase/firebase_tasks_service.dart';
import '../models/route_data_model.dart';
import '../models/todays_task_model.dart';

class RouteController extends GetxController {
  RouteController get instance => Get.find();
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();
  final TaskService _taskService = TaskService();
  final Rx<Map<String, List<LatLng>>> routeData =
      Rx<Map<String, List<LatLng>>>({});
  final RxList<DocumentSnapshot<Map<String, dynamic>>> allRouteDocs =
      <DocumentSnapshot<Map<String, dynamic>>>[].obs;
  final RxList<GeoPoint> routePoints = <GeoPoint>[].obs;
  final RxString userID = ''.obs;
  var tasks = <Task>[].obs;
  RxBool isLoading = false.obs;
  final Set<Marker> markers = {};
  final Set<Polygon> polyline = {};
  final List<LatLng> routePoint = [];
  final Set<Polyline> bestRoute = {};

  @override
  void onInit() async {
    super.onInit();
    await _getUserID();
    getTasksForUser();
    fetchAllRoute();
  }

  Future<void> _getUserID() async {
    userID.value = (await SharedPreferencesService().getUid()) ?? '';
    update();
  }

  Future<void> fetchAllRoute() async {
    try {
      final String userid = (await SharedPreferencesService().getUid())!;
      var result = await _firebaseFirestoreService.fetchAllRouteDocs(userid);

      if (result != null) {
        logError("Number of documents: ${result.docs.length}");
        allRouteDocs.assignAll(result.docs);

        for (var doc in allRouteDocs) {
          _convertAndLogGeoPoints(doc);
        }
      } else {
        _logError("Error fetching all route documents");
      }
    } catch (e) {
      _logError("Error fetching all route documents: $e");
    }
  }

  void _convertAndLogGeoPoints(DocumentSnapshot<Map<String, dynamic>> doc) {
    var docId = doc.id;
    var routeDataList = doc['route'];

    if (routeDataList != null) {
      routePoints.assignAll(routeDataList.map<GeoPoint>((point) {
        return GeoPoint(
          point['latitude'] ?? 0.0,
          point['longitude'] ?? 0.0,
        );
      }).toList());

      List<LatLng> routeCoords = [];
      for (var geoPoint in routePoints) {
        LatLng newLatLng = LatLng(
          geoPoint.latitude,
          geoPoint.longitude,
        );
        routeCoords.add(newLatLng);
        logError(geoPoint.toString());
      }
      routeData.update((val) {
        val![docId] = routeCoords;
      });
    }
  }

  void saveRouteInDB(List<LatLng> routeCoords) async {
    try {
      // Convert List<LatLng> to RouteData
      RouteData routeData = RouteData(route: routeCoords);
      await _firebaseFirestoreService.saveRouteData(userID.value, routeData);
      showCustomSnackBar('Data Saved Successfully', isError: false);
    } catch (e) {
      showCustomSnackBar('Error Saving Data $e');
    }
  }

  void _logError(String message) {
    logError(message);
  }

  void getTasksForUser() async {
    try {
      isLoading.value = true; // Set loading to true when starting to fetch data

      var taskData = await _taskService.getTasksForUser();

      if (taskData.isNotEmpty) {
        tasks.assignAll(
          taskData.map(
            (task) => Task(
              description: task['descraption'],
              location: task['location'],
            ),
          ),
        );
        markersCreator(tasks);
      } else {
        // Handle case when taskData is null or empty
        logError('Task data is null or empty');
      }
    } catch (e) {
      // Handle other errors
      logError('Error fetching tasks from controller: $e');
    } finally {
      isLoading.value =
          false; // Set loading to false when data fetching is complete
    }
  }

  void markersCreator(List<Task> tasks) {
    markers.clear();
    routePoint.clear();

    for (var task in tasks) {
      markers.add(
        Marker(
            markerId: MarkerId(task.description),
            position: LatLng(
              task.location.latitude,
              task.location.longitude,
            ),
            infoWindow: InfoWindow(
              title: task.description,
            )),
      );

      routePoint.add(
        LatLng(
          task.location.latitude,
          task.location.longitude,
        ),
      );
    }
    logError('markers is : $markers');
    logError('routePoint is : $routePoint');
  }

  Future<void> getDirections() async {
    try {
      final MapService mapService = MapService();
      int length = routePoint.length;

      for (int i = 0; i < length - 1; i++) {
        LatLng start = routePoint[i];
        LatLng end = routePoint[i + 1];

        // Use MapService to get directions between start and end
        Map<String, dynamic> directionData =
            await mapService.getDirections(start, end);

        // Decode polyline points
        List<LatLng> polylinePoints = directionData['polyline_decoded'];

        // Create a Polyline and add it to the bestRoute set
        bestRoute.add(
          Polyline(
            polylineId: PolylineId('route_$i'),
            points: polylinePoints,
            width: 3,
            color: Colors.blue,
          ),
        );
        logError('best Route is : ${bestRoute.toList().toString()}');
      }

      update(); // Update the UI to reflect the changes in the bestRoute set
    } catch (e) {
      _logError('Error getting directions: $e');
    }
  }

  @override
  void onReady() {
    fetchAllRoute();
    super.onReady();
  }
}
