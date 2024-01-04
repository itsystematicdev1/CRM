import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final VoidCallback? onBack;
  final List<Widget>? action;
  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.action,
    this.isBackButtonExist = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      //centerTitle: true,
      leading: isBackButtonExist
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : const SizedBox(),
      actions: action ?? [],
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
