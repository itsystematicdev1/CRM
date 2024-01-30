import 'package:salesman/app/widget/snak_bar.dart';
import 'package:salesman/app/helper/log.dart';
import 'package:salesman/app/Routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/shared_pref.dart';
import '../../../service/network/firebase/firebase_service.dart';

class SignInController extends GetxController {
  SignInController get instance => Get.find();
  RxBool loading = false.obs;
  TextEditingController emailController =
      TextEditingController(text: 'user@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  Future<void> loginAccount() async {
    try {
      loading.value = true;
      User? user = await _firebaseAuthService.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (user != null) {
        await _sharedPreferencesService.saveUid(user.uid);
        await _sharedPreferencesService.setIsLoggedIn(true);
        loading.value = false;
        logError('login done successfully');
        Get.toNamed(Routes.onboardingScreen);
      }
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      logError(e.message.toString());
      showCustomSnackBar('Error $e');
    }
  }
}
