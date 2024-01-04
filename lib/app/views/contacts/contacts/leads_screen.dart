import 'package:crm/app/controllers/contacts/leads_controller.dart';
import 'package:crm/app/controllers/contacts/new_contact_controller.dart';
import 'package:crm/app/views/contacts/widget/floating_action_button.dart';
import 'package:crm/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/contact_info_model.dart';
import '../widget/show_bottom_sheet.dart';

class LeadsScreen extends GetView<LeadController> {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Scaffold(
        body: buildInterestedTabView(),
        floatingActionButton: buildFloatingActionButton(
          onAdd: () {
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
        return buildContainerWithText("لا يوجد جهات اتصال لديك");
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
        return buildContainerWithText("لا يوجد جهات اتصال لديك");
      }
    });
  }

  Widget buildLostTabView() {
    return Obx(() {
      if (controller.leads.isNotEmpty) {
        return buildTabContent(controller.leads);
      } else {
        return buildContainerWithText("لا يوجد جهات اتصال لديك");
      }
    });
  }

  Widget buildContainerWithText(String text) {
    return Center(
      child: Text(text),
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
        onRemove: () {
          controller.pressRemove(contact.uId!);
        },
        onLost: () {
          controller.pressMoveToLost(contact);
        },
        onCustomer: () => controller.moveToCustomer(contact),
        onEdit: ()=> controller.pressEditBtn(contact),
        isLead: true,
        isCustomer: false,
        isLost: false,
      ),
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
