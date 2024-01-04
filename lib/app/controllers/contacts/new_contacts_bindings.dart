import 'package:get/get.dart';

import 'new_contact_controller.dart';

class NewContactsBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<NewContactsController>(() => NewContactsController());
  }
}