import 'package:salesman/app/views/authentication/controller/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/signin_body.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('تسجيل الدخول'),
          centerTitle: true,
          elevation: 0,
          surfaceTintColor: Theme.of(context).colorScheme.background,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SignInBody(
            controller: controller,
          ),
        ));
  }
}
