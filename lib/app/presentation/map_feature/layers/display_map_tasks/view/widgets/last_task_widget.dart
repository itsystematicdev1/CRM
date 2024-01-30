import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:salesman/app/constants/app_images.dart';

import '../../../display_google_maps/controller/route_controller.dart';
import '../../../display_google_maps/view/widget/route_history_widget.dart';

class LastTasksList extends StatelessWidget {
  const LastTasksList({
    super.key,
    required this.controller,
  });
  final RouteController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height * 0.1,
      child: Obx(() {
        final List<DocumentSnapshot<Map<String, dynamic>>> allRouteDocs =
            controller.allRouteDocs;
        // Display the list of document IDs
        return allRouteDocs.isEmpty
            ? const Text("")
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allRouteDocs.length,
                itemBuilder: (context, index) {
                  final doc = allRouteDocs[index];
                  final List<dynamic> routeData = doc['route'] ?? [];
                  final List<GeoPoint> routePoints = routeData
                      .map((point) => GeoPoint(
                            point['latitude'] ?? 0.0,
                            point['longitude'] ?? 0.0,
                          ))
                      .toList();

                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () => Get.to(() => RouteHistory(
                              controller: controller,
                              title: doc.id,
                              routePoints: routePoints,
                            )),
                        child: Container(
                          width: context.width * 0.5,
                          height: context.height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(doc.id),
                                const Spacer(),
                                SvgPicture.asset(
                                 Assets.imageDoneIcon,
                                  width: 45,
                                  height: 45,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              );
      }),
    );
  }
}
