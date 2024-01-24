import 'package:salesman/app/views/authentication/controller/signin_bindings.dart';
import 'package:salesman/app/views/map/contoller/map_bindings.dart';
import 'package:salesman/app/views/Home/home_screen.dart';
import 'package:salesman/app/views/authentication/view/signin_screen.dart';
import 'package:salesman/app/views/contacts/view/contacts/contacts_screen.dart';
import 'package:salesman/app/views/contacts/view/contacts/add_contact_screen.dart';
import 'package:salesman/app/views/contacts/view/contacts/loasted_customer.dart';
import 'package:salesman/app/views/map/view/map_screen.dart';
import 'package:salesman/app/views/onboarding/view/on_boardin_screen.dart';
import 'package:salesman/app/views/schadule/view/add_new_schadule_screen.dart';
import 'package:salesman/app/views/schadule/view/schadule_screen.dart';
import 'package:get/get.dart';
import '../views/Home/home_binding.dart';
import '../views/contacts/controller/contacts_bindings.dart';
import '../views/contacts/controller/new_contacts_bindings.dart';
import '../views/schadule/controller/schadule_binding.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.signInScreen,
        page: () => const SignInScreen(),
        binding: SignInBinding(),
        transition: Transition.fadeIn),
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
    GetPage(
        name: Routes.mapScreen,
        page: () => const MapScreen(),
        binding: MapBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.onboardingScreen,
        page: () => OnboardingScreen(),
        transition: Transition.fadeIn),
  ];
}
