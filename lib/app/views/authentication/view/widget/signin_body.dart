import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:salesman/app/constants/app_images.dart';

import '../../controller/signin_controller.dart';
import 'signin_input_form.dart';

class SignInBody extends StatelessWidget {
  final SignInController controller;
  const SignInBody({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: context.height * 0.07,
            ),
            SvgPicture.asset(
              Assets.image100,
              height: context.height * 0.3,
              width: double.infinity,
            ),
            SignInForm(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
