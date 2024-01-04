import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    Color color = Colors.red,
    Duration duration = const Duration(seconds: 3),
    bool isTopSnakbar = true}) {
  Get.showSnackbar(GetSnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    message: message,
    duration: duration,
    snackPosition: isTopSnakbar ? SnackPosition.TOP : SnackPosition.BOTTOM,
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(16),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}
