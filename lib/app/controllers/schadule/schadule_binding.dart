import 'package:get/get.dart';

import 'schadule_controller.dart';

class SchaduleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchaduleController>(() => SchaduleController());
  }
}
