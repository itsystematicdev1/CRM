import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:salesman/app/constants/app_images.dart';

import '../../../Routes/app_pages.dart';
import '../controller/onboarding_controller.dart';
import '../widget/on_boarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({
    super.key,
  });
  final OnBoardingController c = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: c.controller,
          onPageChanged: c.onPageChanged,
          children: [
            OnboardingPage(
              image: Lottie.asset(Assets.imageOnboardingContact,
                  reverse: true),
              title: "Contact Management",
              description:
                  "Streamline your sales journey with our contact management feature. Easily add, edit, or delete contacts, ensuring you have all the information you need at your fingertips. Your customer relationships are now effortlessly organized.",
              currentScreenNo: 0,
            ),
            OnboardingPage(
              image: Lottie.asset(Assets.imageOnboardingSchadule,
                  reverse: true),
              title: "Task Management",
              description:
                  "Boost your productivity with our intuitive task management system. Create tasks, set reminders, and never miss an important deadline. Whether it's a meeting or a follow-up call, stay on top of your tasks and let our app be your personal assistant.",
              currentScreenNo: 1,
            ),
            //lets add 3rd screen
            OnboardingPage(
              image: Lottie.asset(Assets.imageOnboardingLocation,
                  reverse: true),
              title: " Location Tracking",
              description:
                  "Navigate through your day efficiently with real-time location tracking. Know where you need to be and when. Our app not only helps you manage tasks but also ensures you're always on track by providing insights into your current location. Focus on what matters most – closing deals.",
              currentScreenNo: 2,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        height: context.height * 0.088,
        width: double.infinity,
        color: Theme.of(context).colorScheme.background,
        child: Obx(() => Visibility(
              visible: c.page.value == 2,
              replacement: actionButton(),
              child: getStarted(context),
            )),
      ),
    );
  }

  ElevatedButton getStarted(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        openHomeScreen(context);
      },
      child: const Text('ابدأ الأن'),
    );
  }

  Row actionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: c.page.value == 0
                ? const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: () => c.backButton(),
                    child: const Text('رجوع'))),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < 3; index++)
                createProgressDots(index == c.page.value),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () => c.nextButton(),
            child: const Text("التالي"),
          ),
        ),
      ],
    );
  }

  Widget createProgressDots(bool isActiveScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActiveScreen ? 15 : 10,
      width: isActiveScreen ? 15 : 10,
      decoration: BoxDecoration(
        color: isActiveScreen
            ? Theme.of(Get.context!).colorScheme.primary
            : Theme.of(Get.context!).inputDecorationTheme.fillColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void openHomeScreen(BuildContext context) {
    Get.offNamed(Routes.homeScreen);
  }
}
