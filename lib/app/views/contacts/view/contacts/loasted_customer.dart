import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:salesman/app/constants/app_images.dart';
import '../../controller/losted_customer_controller.dart';
import '../../model/contact_info_model.dart';
import '../widget/show_bottom_sheet.dart';

class LostedCustomerScreen extends StatelessWidget {
  LostedCustomerScreen({super.key});

  final LostedCustomerController controller =
      Get.put(LostedCustomerController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Scaffold(
        body: buildInterestedTabView(),
      ),
    );
  }

  Widget buildInterestedTabView() {
    return Obx(() {
      if (controller.leads.isNotEmpty) {
        return buildTabContent(controller.leads);
      } else {
        return buildContainerWithText();
      }
    });
  }

  Widget buildCustomerTabView() {
    return Obx(() {
      if (controller.leads.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: buildTabContent(controller.leads),
        );
      } else {
        return buildContainerWithText();
      }
    });
  }

  Widget buildLostTabView() {
    return Obx(() {
      if (controller.leads.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: buildTabContent(controller.leads),
        );
      } else {
        return buildContainerWithText();
      }
    });
  }

  Widget buildContainerWithText() {
    return Center(
      child: Lottie.asset(Assets.imageEmpty, reverse: true),
    );
  }

  Widget buildTabContent(List<ContactInfoModel> leads) {
    return ListView.builder(
      itemCount: leads.length,
      itemBuilder: (context, index) {
        return buildLeadListTile(context, leads[index]);
      },
    );
  }

  Widget buildLeadListTile(BuildContext context, ContactInfoModel contact) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor:
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.7),
        leading: buildCircleAvatar(context),
        title: Text(contact.name),
        subtitle: contact.phone!.isNotEmpty
            ? Text(contact.phone ?? '')
            : Text(contact.identification ?? ''),
        trailing: buildMoreVertIconButton(context, contact),
      ),
    );
  }

  CircleAvatar buildCircleAvatar(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  IconButton buildMoreVertIconButton(
      BuildContext context, ContactInfoModel contact) {
    return IconButton(
      onPressed: () => showCustomBottomSheet(
        phoneNumber: contact.phone!,
        email: contact.email!,

          onRemove: () => controller.pressRemove(contact.uId!),
          onCustomer: () => controller.pressMoveToCustomer(contact),
          onLead: () => controller.pressMoveToLead(contact),
          isLost: true,
          isCustomer: false,
          isLead: false),
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
