import 'package:salesman/app/presentation/contacts/layers/leads_layer/controller/leads_controller.dart';
import 'package:salesman/app/presentation/schadule/controller/schadule_controller.dart';
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
