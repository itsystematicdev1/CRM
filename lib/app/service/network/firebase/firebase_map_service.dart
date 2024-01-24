import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../helper/log.dart';
import '../../../views/map/models/route_data_model.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> saveRouteData(String userId, RouteData routeData) async {
    try {
      // Check if 'route' collection exists
      final routeCollectionRef = _firestore.collection('route');
      if (!(await routeCollectionRef.doc(userId).get()).exists) {
        // If not, create the 'route' collection
        await routeCollectionRef.doc(userId).set({});
      }

      // Check if user-specific collection exists
      final userCollectionRef =
          routeCollectionRef.doc(userId).collection(userId);
      if (!(await userCollectionRef.get()).docs.isNotEmpty) {
        // If not, create the user-specific collection
        await userCollectionRef.add({});
      }

      // Set doc with formatted date and route data
      await userCollectionRef.doc(formattedDate).set(routeData.toJson());
    } catch (e) {
      logError("Error saving route data: $e");
      rethrow;
    }
  }

  Future<RouteData> getRouteData(String userId, String date) async {
    try {
      final docSnapshot = await _firestore
          .collection('route')
          .doc(userId)
          .collection(userId)
          .doc(date)
          .get();

      if (docSnapshot.exists) {
        return RouteData.fromJson(docSnapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("Document not found");
      }
    } catch (e) {
      logError("Error getting route data: $e");
      // Rethrow the exception to let the calling code handle it
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> fetchAllRouteDocs(
      String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('route')
          .doc(userId)
          .collection(userId)
          .get();

      return snapshot;
    } catch (e) {
      logError("Error fetching route docs: $e");
      // Rethrow the exception to let the calling code handle it
      rethrow;
    }
  }
}
