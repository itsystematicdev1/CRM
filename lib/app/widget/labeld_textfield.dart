import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<String>? autoFill;
  final bool? obscureText;
  final bool? enableBoarder;
  final int? maxLine;
  final bool? isRequired;
  final Widget? sufix;

  const LabeledTextField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      this.maxLine,
      this.isRequired,
      this.keyboardType,
      this.obscureText,
      this.autoFill,
      this.enableBoarder,
      this.sufix});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: Theme.of(context).textTheme.labelLarge),
            if (isRequired == true)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red, // Red color for the asterisk
                ),
              ),
          ],
        ),
        const SizedBox(height: 8.0), // Adjust the spacing as needed
        TextFormField(
          obscureText: obscureText ?? false,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          maxLines: maxLine ?? 1,
          autofillHints: autoFill ?? [],
          minLines: 1,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelMedium,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: enableBoarder ?? false
                  ? BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    )
                  : const BorderSide(color: Color(0xFFFFFFFF), width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.0,
              ),
            ),
            suffixIcon: sufix ?? const Text(''),
          ),
        ),
      ],
    );
  }
}
