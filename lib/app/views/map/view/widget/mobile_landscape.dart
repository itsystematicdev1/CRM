import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contoller/map_controller.dart';
import '../../contoller/route_controller.dart';
import '../../../../widget/custom_appbar.dart';
import 'map_widget.dart';

class MobileLandScape extends StatelessWidget {
  const MobileLandScape({
    super.key,
    required this.controller,
  });

  final MapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(
        isBackButtonExist: false,
        title: '',
        action: [
          FloatingActionButton.extended(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
            onPressed: () => controller.changeWorkSatus(),
            label: Obx(() => controller.startWork.value == true
                ? Text(
                    'انت قيد المتابعة',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                : Text('بدأ الدوام',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimary))),
            icon: Obx(() => Icon(
                  controller.startWork.value == true
                      ? Icons.stop
                      : Icons.play_arrow_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
          )
        ],
      ),
      body: MapWidget(controller: controller, markers: RouteController().instance.markers, route: RouteController().instance.bestRoute),
    );
  }
}
