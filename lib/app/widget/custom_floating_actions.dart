import 'package:flutter/material.dart';

class CustomFloatingActionBotton extends StatelessWidget {
  const CustomFloatingActionBotton({
    super.key,
    this.onTap,
    required this.hero,
  });

  final VoidCallback? onTap;
  final String hero;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: onTap ?? () {},
        heroTag: Text(hero),
        child: const Icon(
          Icons.add_rounded,
          size: 45,
        ));
  }
}
