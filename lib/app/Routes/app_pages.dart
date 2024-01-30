import 'package:salesman/app/presentation/authentication/controller/signin_bindings.dart';
import 'package:salesman/app/presentation/map_feature/layers/display_map_tasks/controller/map_bindings.dart';
import 'package:salesman/app/presentation/Home/view/home_screen.dart';
import 'package:salesman/app/presentation/authentication/view/signin_screen.dart';
import 'package:salesman/app/presentation/contacts/layers/contacts_controll_screen/view/contacts_screen.dart';
import 'package:salesman/app/presentation/contacts/layers/add_new_contact/view/add_contact_screen.dart';
import 'package:salesman/app/presentation/contacts/layers/lost_contact_layer/view/loasted_customer.dart';
import 'package:salesman/app/presentation/onboarding/view/on_boardin_screen.dart';
import 'package:salesman/app/presentation/schadule/view/add_new_schadule_screen.dart';
import 'package:salesman/app/presentation/schadule/view/schadule_screen.dart';
import 'package:get/get.dart';
import '../presentation/Home/controller/home_binding.dart';
import '../presentation/contacts/layers/add_new_contact/controller/new_contacts_bindings.dart';
import '../presentation/contacts/layers/contacts_controll_screen/controller/contacts_bindings.dart';
import '../presentation/map_feature/layers/display_google_maps/map_screen.dart';
import '../presentation/schadule/controller/schadule_binding.dart';

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
