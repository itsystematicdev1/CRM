import 'package:salesman/app/views/contacts/view/contacts/contacts_screen.dart';
import 'package:salesman/app/views/schadule/view/schadule_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../map/view/location_screen.dart';

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
