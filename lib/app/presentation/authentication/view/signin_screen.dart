import 'package:salesman/app/presentation/authentication/controller/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/signin_body.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      
        body: SignInBody(
          controller: controller,
        ));
  }
}
