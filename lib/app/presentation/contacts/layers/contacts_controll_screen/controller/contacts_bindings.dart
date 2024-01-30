import 'package:salesman/app/service/database/customer_database.dart';
import 'package:salesman/app/service/database/leads_database.dart';
import 'package:salesman/app/service/database/lost_customer_database.dart';
import 'package:get/get.dart';
import '../../customer_layer/controller/customer_controller.dart';
import '../../leads_layer/controller/leads_controller.dart';
import '../../lost_contact_layer/controller/losted_customer_controller.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    LeadsDatabase().initDatabase();
    CustomersDatabase().initDatabase();
    LostedCustomersDatabase().initDatabase();
    Get.lazyPut<LeadController>(() => LeadController());
    Get.lazyPut<CustomerController>(() => CustomerController());
    Get.lazyPut<LostedCustomerController>(() => LostedCustomerController());
  }
}
