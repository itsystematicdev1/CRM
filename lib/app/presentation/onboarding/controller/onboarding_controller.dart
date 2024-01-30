import 'package:salesman/app/helper/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Routes/app_pages.dart';

class OnBoardingController extends GetxController {
  final controller = PageController();
  var page = 0.obs;

  void onPageChanged(int pageIndex) {
    page.value = pageIndex;
  }

  void nextButton() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    page.value = page.value + 1;
    update();
  }

  void backButton() {
    controller.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    page.value = page.value - 1;
    update();
  }

  void goButton() async {
    await SharedPreferencesService().setIsLoggedIn(true);
    Get.offAllNamed(Routes.homeScreen);
  }
}
