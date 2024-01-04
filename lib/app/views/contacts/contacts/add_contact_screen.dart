import 'package:crm/app/controllers/contacts/new_contact_controller.dart';
import 'package:crm/app/widget/custom_appbar.dart';
import 'package:crm/app/widget/custom_text_field.dart';
import 'package:crm/helper/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewContactScreen extends GetView<NewContactsController> {
  const AddNewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
      appBar: CustomAppBar(title: controller.title.value),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.height * 0.85,
            child: Column(
              children: [
                buildBasicInfoCard(context),
                const SizedBox(height: 20),
                buildContactInfoCard(context),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ElevatedButton(
          onPressed: () => controller.saveContact(),
          child: const Text('Save'),
        ),
      ),
    );
  }

  Widget buildBasicInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            10.ph,
            buildTextField('Full Name', controller.name),
            20.ph,
            buildTextField('Identification', controller.identification),
          ],
        ),
      ),
    );
  }

  Widget buildContactInfoCard(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSwitchCard(
                'Phone', controller.showPhoneField, controller.phone),
            buildSwitchCard(
                'Email', controller.showEmailField, controller.email),
            buildSwitchCard(
              'Additional Information',
              controller.showAddinform,
              controller.additionalInformation,
            ),
          ],
        ));
  }

  Widget buildSwitchCard(
      String label, RxBool switchValue, TextEditingController textController) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label),
                Switch.adaptive(
                  value: switchValue.value,
                  onChanged: (value) {
                    textController.clear();
                    switchValue.toggle();
                  },
                ),
              ],
            ),
            if (switchValue.value) buildTextField(label, textController),
            15.ph,
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: Theme.of(Get.context!).textTheme.labelMedium,
        ),
        5.ph,
        CustomTextField(
          hintText: hintText,
          controller: controller,
        ),
      ],
    );
  }
}
