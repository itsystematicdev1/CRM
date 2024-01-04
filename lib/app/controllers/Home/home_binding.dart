import 'package:crm/app/controllers/contacts/leads_controller.dart';
import 'package:crm/app/controllers/schadule/schadule_controller.dart';
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
