import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesman/app/constants/app_images.dart';

class SignInImageWidget extends StatelessWidget {
  const SignInImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imageLogin,
      width: context.width * 0.7,
      height: context.height * 0.25,
    );
  }
}
