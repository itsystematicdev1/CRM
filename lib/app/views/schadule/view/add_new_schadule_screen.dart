import 'package:salesman/app/views/schadule/controller/schadule_controller.dart';
import 'package:salesman/app/widget/custom_appbar.dart';
import 'package:salesman/app/widget/labeld_textfield.dart';
import 'package:salesman/app/helper/empty_padding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../contacts/model/contact_info_model.dart';

class AddNewScaduleScreen extends GetView<SchaduleController> {
  const AddNewScaduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'اجتماع جديد'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBasicInfoCard(context),
              20.ph,
              Text(
                "تفاصيل الأجتماع",
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              15.ph,
              buildMeetingDetaild(context),
              15.ph,
              buildMeetingDate(context),
              15.ph,
              buildMeetingTimeFrom(context),
              15.ph,
              buildMeetingTimeTo(context),
              15.ph,
              buildMeetingAddress(context),
              30.ph,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                    onPressed: () {
                      controller.addNewMeeting();
                    },
                    child: const Text('حفظ الأجتماع')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBasicInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).inputDecorationTheme.fillColor),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'ربط جهة الأتصال',
                style: Theme.of(Get.context!).textTheme.labelLarge,
              ),
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red, // Red color for the asterisk
                ),
              ),
            ],
          ),
          Obx(() {
            return Container(
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: () {},
                    child: DropdownButton<ContactInfoModel>(
                      isExpanded: true,
                      alignment: AlignmentDirectional.center,

                      isDense: true,
                      icon: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      value: controller.selectedContact.value,
                      underline: Container(), // Hide the underline
                      items:
                          controller.contacts.map((ContactInfoModel contact) {
                        return DropdownMenuItem<ContactInfoModel>(
                          value: contact,
                          child: Text(contact.name),
                        );
                      }).toList(),
                      onChanged: (ContactInfoModel? newValue) {
                        controller.selectedContact.value = newValue;
                      },
                    ),
                  )),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildMeetingDetaild(BuildContext context) {
    return Column(
      children: [
        LabeledTextField(
          label: 'وصف الاجتماع',
          hintText: '',
          controller: controller.descriptionController,
          isRequired: true,
          maxLine: 4,
        )
      ],
    );
  }

  Widget buildMeetingDate(BuildContext context) {
    return Column(
      children: [
        LabeledTextField(
          label: 'تاريخ الأجتماع',
          hintText: '',
          controller: controller.dateController,
          isRequired: true,
          sufix: IconButton(
              onPressed: () => controller.selectDate(context),
              icon: Icon(
                Icons.dataset_outlined,
                color: Colors.blueAccent.shade400,
              )),
        )
      ],
    );
  }

  Widget buildMeetingTimeFrom(BuildContext context) {
    return Column(
      children: [
        LabeledTextField(
          label: "من ",
          hintText: '',
          controller: controller.timeController,
          isRequired: true,
          sufix: IconButton(
              onPressed: () => controller.selectTime(context),
              icon: Icon(
                Icons.timelapse_rounded,
                color: Colors.redAccent.shade400,
              )),
        )
      ],
    );
  }

  Widget buildMeetingTimeTo(BuildContext context) {
    return Column(
      children: [
        LabeledTextField(
          label: "الي ",
          hintText: '',
          controller: controller.timeToController,
          isRequired: true,
          sufix: IconButton(
              onPressed: () => controller.selectToTime(context),
              icon: Icon(
                Icons.timelapse_rounded,
                color: Colors.redAccent.shade400,
              )),
        )
      ],
    );
  }

  Widget buildMeetingAddress(BuildContext context) {
    return Column(
      children: [
        LabeledTextField(
          label: 'عنوان الاجتماع',
          hintText: '',
          controller: controller.addressController,
          isRequired: false,
          maxLine: 2,
        )
      ],
    );
  }
}
