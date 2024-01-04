import 'package:crm/app/views/Home/home_screen.dart';
import 'package:crm/app/views/contacts/contacts/contacts_screen.dart';
import 'package:crm/app/views/contacts/contacts/add_contact_screen.dart';
import 'package:crm/app/views/contacts/contacts/loasted_customer.dart';
import 'package:crm/app/views/schadule/add_new_schadule_screen.dart';
import 'package:crm/app/views/schadule/schaule_screen.dart';
import 'package:get/get.dart';
import '../app/controllers/Home/home_binding.dart';
import '../app/controllers/contacts/contacts_bindings.dart';
import '../app/controllers/contacts/new_contacts_bindings.dart';
import '../app/controllers/schadule/schadule_binding.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.homeScreen,
        page: () => const HomeScreen(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.addNewContactScreen,
        page: () => const AddNewContactScreen(),
        binding: NewContactsBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.contactsScreen,
        page: () => const ContactsScreen(),
        binding: ContactBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.lostedCustomerScreen,
        page: () => LostedCustomerScreen(),
        binding: ContactBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.addNewSchaduleScreen,
        page: () => const AddNewScaduleScreen(),
        binding: SchaduleBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.schaduleScreen,
        page: () => const SchaduleScreen(),
        binding: SchaduleBinding(),
        transition: Transition.fadeIn),
  ];
}
