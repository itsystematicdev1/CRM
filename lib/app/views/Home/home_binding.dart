import 'package:salesman/app/views/contacts/controller/leads_controller.dart';
import 'package:salesman/app/views/schadule/controller/schadule_controller.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut<LeadController>(() => LeadController());
    Get.lazyPut<SchaduleController>(() => SchaduleController());
  }
}
