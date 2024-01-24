import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../helper/log.dart';
import '../../../helper/shared_pref.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getTasksForUser() async {
    try {
      final String? userid = await SharedPreferencesService().getUid();

      if (userid == null) {
        logError('User ID is null.');
        return [];
      }

      final formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      logError('Formatted Date: $formattedDate');

      var document =
          await _firestore.collection('tasks').doc('15-01-2024').get();
      logError('Firestore Document Retrieved');

      if (document.exists) {
        var userData = document.data();
        logError('User Data: $userData');

        if (userData != null && userData[userid] != null) {
          List<Map<String, dynamic>> userTasks =
              (userData[userid] as List<dynamic>)
                  .map((task) => task as Map<String, dynamic>)
                  .toList();
          logError('Today\'s tasks: ${userTasks.toString()}');
          return userTasks;
        } else {
          logError('User ID not found or user tasks are null.');
          return [];
        }
      } else {
        logError('Document does not exist.');
        return [];
      }
    } catch (e) {
      logError('Error fetching tasks: $e');
      throw Exception('Error fetching tasks: $e');
    }
  }
}
