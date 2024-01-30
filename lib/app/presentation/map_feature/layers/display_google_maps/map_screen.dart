import 'package:salesman/app/presentation/map_feature/layers/display_map_tasks/controller/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../display_map_tasks/view/widgets/mobile_landscape.dart';
import '../display_map_tasks/view/widgets/mobile_portrait.dart';

class MapScreen extends GetView<MapController> {
  const MapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return MobilePortrait(controller: controller);
      } else if (constraints.maxWidth < 900) {
        return MobileLandScape(controller: controller);
      } else {
        return MobileLandScape(controller: controller);
      }
    });
  }
}
