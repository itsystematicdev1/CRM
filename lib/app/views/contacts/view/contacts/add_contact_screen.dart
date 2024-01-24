import 'package:salesman/app/views/contacts/controller/new_contact_controller.dart';
import 'package:salesman/app/widget/custom_appbar.dart';
import 'package:salesman/app/widget/custom_text_field.dart';
import 'package:salesman/app/helper/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewContactScreen extends GetView<NewContactsController> {
  const AddNewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? Theme.of(context).colorScheme.background
          : Theme.of(context).inputDecorationTheme.fillColor,
      appBar: CustomAppBar(title: controller.title.value),
      body: Padding(
        padding: EdgeInsets.only(
            bottom: context.height * 0.085, top: 16, right: 16, left: 16),
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
      bottomSheet: Container(
        color: Theme.of(context).cardTheme.color,
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
            buildTextField('Phone', controller.phone),
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
                Text(
                  label,
                  style: Theme.of(Get.context!).textTheme.labelLarge,
                ),
                Switch.adaptive(
                  value: switchValue.value,
                  onChanged: (value) {
                    textController.clear();
                    switchValue.toggle();
                  },
                ),
              ],
            ),
            if (switchValue.value)
              buildTextField(label, textController, isLabel: false),
            15.ph,
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller,
      {bool isLabel = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLabel
            ? Text(
                hintText,
                style: Theme.of(Get.context!).textTheme.labelMedium,
              )
            : const SizedBox.shrink(),
        5.ph,
        CustomTextField(
          hintText: hintText,
          controller: controller,
        ),
      ],
    );
  }
}
