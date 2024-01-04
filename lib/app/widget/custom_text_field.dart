import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<String>? autoFill;
  final bool? obscureText;
  final bool? enableBoarder;
  final int? maxLine;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLine,
    this.keyboardType,
    this.obscureText,
    this.autoFill,
    this.enableBoarder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: maxLine ?? 1,
      autofillHints: autoFill??[],
      minLines: 1,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: enableBoarder ?? false
              ? BorderSide(color: Theme.of(context).colorScheme.outline)
              : const BorderSide(color: Color(0xFFFFFFFF), width: 0.1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.0),
        ),
      ),
    );
  }
}
