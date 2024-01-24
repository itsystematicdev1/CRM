import 'package:flutter/material.dart';

class CustomButtomSheet extends StatelessWidget {
  const CustomButtomSheet({
    super.key,
    required this.title,
    required this.btnTap,
  });
  final String title;
  final VoidCallback btnTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.only(bottom: 14, left: 14, right: 14),
        child: ElevatedButton(onPressed: btnTap, child: Text(title)));
  }
}
