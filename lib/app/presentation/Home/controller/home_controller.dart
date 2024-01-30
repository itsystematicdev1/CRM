import 'package:salesman/app/presentation/contacts/layers/contacts_controll_screen/view/contacts_screen.dart';
import 'package:salesman/app/presentation/schadule/view/schadule_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../map_feature/layers/display_map_tasks/location_screen.dart';

class HomeController extends GetxController {
  HomeController get instance => Get.find();
  RxInt currentindex = 0.obs;

  List<Widget> screens = [
    LocationScreen(),
    const ContactsScreen(),
    const SchaduleScreen(),
  ];

  void updateBarIndex(int index) {
    currentindex.value = index;
    update();
  }
}
