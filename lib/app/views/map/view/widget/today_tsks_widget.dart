import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../Routes/app_pages.dart';
import '../../../../constants/app_images.dart';
import '../../contoller/route_controller.dart';

// ... your imports

class TodayTasksWidget extends StatelessWidget {
  const TodayTasksWidget({super.key, required this.taskController});

  final RouteController taskController;

  @override
  Widget build(BuildContext context) {
    // taskController.getTasksForUser();
    return SizedBox(
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.transparent,
            leading: Text(
              'مهام اليوم',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              RouteController().instance.getDirections();
              Get.toNamed(Routes.mapScreen);
            },
          ),
          Expanded(
            // Wrap your ListView.builder with Expanded
            child: Obx(
              () {
                if (taskController.isLoading.value) {
                  return Lottie.asset(Assets.imageLoadingData);
                } else if (taskController.tasks.isEmpty) {
                  // Display a message when no tasks are found
                  return Lottie.asset(Assets.imageNoData);
                } else {
                  // Display the tasks when available
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      var task = taskController.tasks[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: context.height * 0.08,
                          width: context.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor!,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            tileColor: Colors.transparent,
                            leading: Text(
                              '$index',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            title: Text(
                              task.description,
                              softWrap: true,
                            ),
                            trailing: SvgPicture.asset(
                              index % 2 == 0
                                  ? Assets.image100
                                  : Assets.image0,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
