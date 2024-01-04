import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomOption {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  CustomOption({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });
}

List<Widget> buildOptions(List<CustomOption> options,
    {bool isLead = true, bool isCustomer = true, bool isLost = false}) {
  return options
      .where((option) {
        if (isLead && option.label != 'فرصة') return true;
        if (isCustomer && option.label != 'عميل') return true;
        if (isLost && option.label != 'فقد') return true;
        return false;
      })
      .map((option) => _buildOption(option))
      .toList();
}

void showCustomBottomSheet({
  void Function()? onRemove,
  void Function()? onCustomer,
  void Function()? onLost,
  void Function()? onEdit,
  void Function()? onLead,
  bool isLost = false,
  bool isCustomer = false,
  bool isLead = true,
}) {
  List<CustomOption> options = [
    CustomOption(
      icon: Icons.note_alt_outlined,
      label: 'تعديل',
      onPressed: onEdit ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
    CustomOption(
      icon: Icons.how_to_reg_outlined,
      label: 'عميل',
      onPressed: onCustomer ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
    CustomOption(
      icon: Icons.person_remove_alt_1_outlined,
      label: 'فقد',
      onPressed: onLost ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
    CustomOption(
      icon: Icons.person_outline_rounded,
      label: 'فرصة',
      onPressed: onLead ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
    CustomOption(
      icon: Icons.delete_outline_rounded,
      label: 'خذف',
      onPressed: onRemove ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
  ];

  Get.bottomSheet(
    backgroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    SizedBox(
      height: Get.context!.height * 0.25,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(Get.context!).colorScheme.outlineVariant,
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Text('الخيارات'),
            ),
          ),
          const Spacer(),
          Container(
            color: Theme.of(Get.context!).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: buildOptions(options,
                    isLead: isLead, isCustomer: isCustomer, isLost: isLost),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOption(CustomOption option) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GestureDetector(
      onTap: option.onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            option.icon,
            color: option.color,
          ),
          Text(
            option.label,
            style: TextStyle(color: option.color),
          ),
        ],
      ),
    ),
  );
}
