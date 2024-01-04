import 'package:crm/app/views/contacts/contacts/contacts_screen.dart';
import 'package:crm/app/views/schadule/schaule_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController get instance => Get.find();
  RxInt currentindex = 0.obs;

  List<Widget> screens = [
    const ContactsScreen(),
    const SchaduleScreen(),
    const ContactsScreen()
  ];

  void updateBarIndex(int index) {
    currentindex.value = index;
    update();
  }
}
