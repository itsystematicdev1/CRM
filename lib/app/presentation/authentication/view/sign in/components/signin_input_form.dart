import 'package:salesman/app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/signin_controller.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key, required this.controller, this.mainAxisAlignment});

  final SignInController controller;
  final MainAxisAlignment? mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment??  MainAxisAlignment.start,
      children: [
        const Text(
          'البريد ',
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(hintText: '', controller: controller.emailController),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'كلمة المرور ',
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          hintText: '',
          controller: controller.passwordController,
        ),
        const SizedBox(
          height: 30,
        ),
        Obx(() => ElevatedButton(
              onPressed: () {
                controller.loginAccount();
              },
              child: controller.loading.value == true
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : const Text('تسجيل الدخول'),
            )),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
