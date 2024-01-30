import 'package:salesman/app/constants/app_images.dart';
import 'package:salesman/app/presentation/contacts/layers/customer_layer/controller/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../helper/log.dart';
import '../../../../../Routes/app_pages.dart';
import '../../add_new_contact/controller/new_contact_controller.dart';
import '../../../model/contact_info_model.dart';
import '../../../../../widget/custom_floating_actions.dart';
import '../../../widget/show_bottom_sheet.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({super.key});

  final CustomerController controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Scaffold(
        body: buildInterestedTabView(),
        floatingActionButton: CustomFloatingActionBotton(
            hero: 'Customer',
            onTap: () {
              final NewContactsController c = Get.put(NewContactsController());
              c.customer = true.obs;
              c.leads = false.obs;
              Get.toNamed(Routes.addNewContactScreen);
            }),
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
          email: contact.email!,
          phoneNumber: contact.phone!,
          onRemove: () {
            logError('remove ${contact.uId}');
            controller.pressRemove(contact.uId!);
          },
          onLead: () => controller.pressMoveToLead(contact),
          onLost: () => controller.pressMoveToLost(contact),
          onEdit: () => controller.pressEditBtn(contact),
          isCustomer: true,
          isLead: false,
          isLost: false),
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
