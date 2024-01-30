import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:salesman/app/constants/app_images.dart';
import 'package:salesman/app/helper/test_size_helper.dart';
import '../../controller/signin_controller.dart';
import '../sign in/components/signin_input_form.dart';

class SignInBody extends StatelessWidget {
  final SignInController controller;

  const SignInBody({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 500) {
        return tabView(context);
      } else {
        return mobilePortraitView(context);
      }
    });
  }

  Column mobilePortraitView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: context.height * 0.07,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Lottie.asset(
            Assets.loginForm,
            reverse: true,
            repeat: true,
            height: context.height * 0.3,
            width: context.width ,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SignInForm(
            controller: controller,
          ),
        ),
      ],
    );
  }

  Row tabView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تسجيل الدخول',
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: getFontSize(context, fontSize: 30)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: SignInForm(
                  mainAxisAlignment: MainAxisAlignment.center,
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Lottie.asset(
            Assets.loginForm,
            reverse: true,
            repeat: true,
            height: context.height * 0.6,
            width: context.width * 0.4,
          ),
        ),
      ],
    );
  }
}
