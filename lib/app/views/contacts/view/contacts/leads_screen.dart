import 'package:salesman/app/constants/app_images.dart';
import 'package:salesman/app/views/contacts/controller/leads_controller.dart';
import 'package:salesman/app/views/contacts/controller/new_contact_controller.dart';
import 'package:salesman/app/widget/custom_floating_actions.dart';
import 'package:salesman/app/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../model/contact_info_model.dart';
import '../widget/show_bottom_sheet.dart';

class LeadsScreen extends GetView<LeadController> {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Scaffold(
        body: buildInterestedTabView(),
        floatingActionButton: CustomFloatingActionBotton(
          hero: 'Leeds',
          onTap: () {
            final NewContactsController c = Get.put(NewContactsController());
            c.leads = true.obs;
            c.customer = false.obs;
            Get.toNamed(Routes.addNewContactScreen);
          },
        ),
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
        return buildTabContent(controller.leads);
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
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SvgPicture.asset(
        'assets/image/profile_icon.svg',
        width: 40,
        height: 40,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  IconButton buildMoreVertIconButton(
      BuildContext context, ContactInfoModel contact) {
    return IconButton(
      onPressed: () => showCustomBottomSheet(
        phoneNumber: contact.phone!,
        email: contact.email!,
        onRemove: () {
          controller.pressRemove(contact.uId!);
        },
        onLost: () {
          controller.pressMoveToLost(contact);
        },
        onCustomer: () => controller.moveToCustomer(contact),
        onEdit: () => controller.pressEditBtn(contact),
        isLead: true,
        isCustomer: false,
        isLost: false,
      ),
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
