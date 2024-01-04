import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Home/home_controller.dart';

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
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.group_outlined,
                    ),
                    label: 'جهات الاتصال',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_rounded),
                    label: 'جدول',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.event_note_rounded),
                    label: 'ملاحظة',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
