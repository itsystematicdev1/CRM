import 'package:salesman/app/views/map/contoller/route_controller.dart';
import 'package:salesman/app/widget/bottom_sheet_btn.dart';
import 'package:salesman/app/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../contoller/map_controller.dart';
import '../../../../widget/custom_appbar.dart';
import 'map_widget.dart';

class MobilePortrait extends StatelessWidget {
  const MobilePortrait({
    super.key,
    required this.controller,
  });

  final MapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      appBar: CustomAppBar(
        title: 'الخرائط',
        onBack: () {
          controller.routeCoords.clear();
          Get.toNamed(Routes.homeScreen);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 80,
        ),
        child: MapWidget(
            controller: controller,
            markers: RouteController().instance.markers,
            route: RouteController().instance.bestRoute),
      ),
      bottomSheet: Obx(() => CustomButtomSheet(
          btnTap: controller.startWork.value == true
              ? () {
                  controller.pressStopWorking();
                  controller.sendEmailWithGoogleMapsLink();
                }
              : () => controller.changeWorkSatus(),
          title: controller.startWork.value == true
              ? 'انت قيد المتابعة'
              : 'بدأ الدوام')),
    );
  }
}
