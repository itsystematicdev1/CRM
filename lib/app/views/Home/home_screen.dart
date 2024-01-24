import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3, // Number of tabs
        child: Obx(
          () => Scaffold(
            body: IndexedStack(
              index: controller.currentindex.value,
              children: controller.screens,
            ),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                currentIndex: controller.currentindex.value,
                onTap: (index) => controller.updateBarIndex(index),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentindex.value == 0
                          ? Icons.home_rounded
                          : Icons.home_outlined,
                    ),
                    label: 'الرئيسية',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentindex.value == 1
                          ? Icons.group
                          : Icons.group_outlined,
                    ),
                    label: 'جهات الاتصال',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.list_rounded),
                    label: 'جدول',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
