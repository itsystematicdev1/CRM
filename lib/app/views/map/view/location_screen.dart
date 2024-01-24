import 'package:salesman/app/constants/app_images.dart';
import 'package:salesman/app/helper/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../contoller/route_controller.dart';
import 'widget/last_task_widget.dart';
import 'widget/today_tsks_widget.dart';

class LocationScreen extends StatelessWidget {
  final RouteController _routeController = Get.put(RouteController());

  LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LayoutBuilder(builder: (context, constrains) {
          if (constrains.maxWidth < 600) {
            return portraitWidgets(context);
          } else {
            return portraitWidgets(context);
          }
        }),
      ),
    );
  }

  SizedBox portraitWidgets(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _welcomeImage(context)),
          Expanded(
            flex: 1,
            child: LastTasksList(
              controller: _routeController,
            ),
          ),
          Expanded(
              flex: 3,
              child: TodayTasksWidget(
                taskController: _routeController,
              ))
        ],
      ),
    );
  }

  SizedBox _welcomeImage(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.height * 0.23,
      child: Center(
        child: SvgPicture.asset(Assets.imageHomeDialog),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      iconTheme: const IconThemeData(opticalSize: 40, size: 40),
      actionsIconTheme: const IconThemeData(opticalSize: 40, size: 40),
      leading: Row(
        children: [
          10.pw,
          GestureDetector(
            child: SvgPicture.asset(
              Assets.imageProfileIcon,
              width: 40,
              height: 40,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
      leadingWidth: 50,
      actions: [
        GestureDetector(
          child: SvgPicture.asset(
           Assets.imageSettingsIcon,
            width: 40,
            height: 40,
          ),
        ),
        10.pw,
      ],
    );
  }
}
