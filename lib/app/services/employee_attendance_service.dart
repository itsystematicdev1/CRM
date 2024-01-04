// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/testapi/emp_mpdels.dart';

// class EmployeeAttendanceService {
//   Future<EmployeeAttendanceModel> getEmployeeAttendance() async {
//     var headers = {
//       'Authorization': 'token 418707a0d17eec4:9f2547fafde025f',
//     };
//     var response = await http.get(
//       Uri.parse('http://192.168.1.10:8072/api/method/pp_addon.endpoints.api.get_employee_attendance'),
//       headers: headers,
//     );
//     if (response.statusCode == 200) {
//       return EmployeeAttendanceModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load employee attendance');
//     }
//   }
// }
