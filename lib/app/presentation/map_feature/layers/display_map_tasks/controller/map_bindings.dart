import 'package:get/get.dart';

import 'map_controller.dart';

class MapBinding implements Bindings {
@override
void dependencies() {
  Get.put(MapController(), permanent: true);
  }
}