import 'package:salesman/app/constants/app_images.dart';
import 'package:salesman/app/widget/snak_bar.dart';
import 'package:salesman/app/helper/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomOption {
  final String icon;
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
  required String phoneNumber,
  required String email,
  bool isLost = false,
  bool isCustomer = false,
  bool isLead = true,
}) {
  List<CustomOption> options = [
    CustomOption(
      icon: Assets.imageEdit,
      label: 'تعديل',
      onPressed: onEdit ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
    CustomOption(
      icon: Assets.imageCustomer,
      label: 'عميل',
      onPressed: onCustomer ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
    CustomOption(
      icon: Assets.imageLostContact,
      label: 'فقد',
      onPressed: onLost ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
    CustomOption(
      icon: Assets.imageAddLead,
      label: 'فرصة',
      onPressed: onLead ?? () {},
      color: Theme.of(Get.context!).colorScheme.onPrimary,
    ),
    CustomOption(
      icon: Assets.imageTrush,
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
      height: Get.context!.height * 0.2,
      width: double.infinity,
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  try {
                    if (await canLaunchUrl(Uri.parse(
                        'mailto:$email?subject=From New era &body= hi '))) {
                      await launchUrl(Uri.parse(
                          'mailto:$email?subject=From New era &body= hi '));
                    } else {
                      showCustomSnackBar("Could not launch URL");
                    }
                  } catch (e) {
                    // Handle any exceptions that occur during the launch attempt
                    showCustomSnackBar("Error launching URL: $e");
                  }
                },
                child: SvgPicture.asset(
                  Assets.imageGmail,
                  width: 50,
                  height: 50,
                ),
              ),
              20.pw,
              GestureDetector(
                onTap: email.isNotEmpty
                    ? () async {
                        try {
                          if (await canLaunchUrl(
                              Uri.parse("https://wa.me/$phoneNumber?text="))) {
                            await launchUrl(
                                Uri.parse("https://wa.me/$phoneNumber?text="));
                          } else {
                            showCustomSnackBar("Could not launch URL");
                          }
                        } catch (e) {
                          showCustomSnackBar("Error launching URL: $e");
                        }
                      }
                    : () => showCustomSnackBar('Email is empty'),
                child: SvgPicture.asset(
                  Assets.imageWhatsapp,
                  width: 50,
                  height: 50,
                ),
              ),
            ],
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
          SvgPicture.asset(
            option.icon,
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
