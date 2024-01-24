import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.currentScreenNo});

  final LottieBuilder image;

  final String title;

  final String description;

  final int currentScreenNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            onboardingBody(),
          ],
        ));
  }

  Expanded onboardingBody() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: Get.context!.width,
              height: Get.context!.height * 0.4,
              child: image),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: Theme.of(Get.context!)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
