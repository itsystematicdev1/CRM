import 'package:salesman/app/presentation/contacts/layers/lost_contact_layer/controller/losted_customer_controller.dart';
import 'package:salesman/app/service/database/customer_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Routes/app_pages.dart';
import '../../../../../service/database/leads_database.dart';
import '../../../../../service/database/lost_customer_database.dart';
import '../../../model/contact_info_model.dart';
import '../../../../../widget/snak_bar.dart';
import '../../leads_layer/controller/leads_controller.dart';
import '../../add_new_contact/controller/new_contact_controller.dart';

class CustomerController extends GetxController {
  CustomerController get instance => Get.find();
  final LeadsDatabase _leadsDatabase = LeadsDatabase();
  final LostedCustomersDatabase _lostCustomersDatabase =
      LostedCustomersDatabase();
  final CustomersDatabase _customersDatabase = CustomersDatabase();
  RxBool fetchData = false.obs;
  late TabController tabBarController;
  final RxList<ContactInfoModel> leads = <ContactInfoModel>[].obs;

  Future<void> fetchLeads() async {
    leads.value = await _customersDatabase.getAllContacts();
  }

  Future<void> removeLeads(int id) async {
    await _customersDatabase.removeCustomer(id);
  }

  Future<void> moveToLost(ContactInfoModel contact) async {
    await _lostCustomersDatabase.insertLostedCustomer(contact);
    LostedCustomerController().instance.fetchLeads();
    await _customersDatabase.removeCustomer(contact.uId!);
    leads.clear();
  }

  Future<void> moveToLead(ContactInfoModel contact) async {
    await _leadsDatabase.insertContact(contact);
    LeadController().instance.fetchLeads();
    await _customersDatabase.removeCustomer(contact.uId!);
    leads.clear();
  }

  void pressRemove(int id) async {
    leads.clear();
    await removeLeads(id);
    showCustomSnackBar('تم حذف جهة الاتصال بنجاح');
    fetchLeads();
  }

  void pressMoveToLead(ContactInfoModel contact) async {
    await moveToLead(contact);
    leads.clear();
    showCustomSnackBar('تم نقل جهة الاتصال بنجاح', isError: false);
    fetchLeads();
    _leadsDatabase.getAllContacts();
  }

  void pressMoveToLost(ContactInfoModel contact) async {
    await moveToLost(contact);
    leads.clear();
    showCustomSnackBar('تم نقل جهة الاتصال بنجاح', isError: false);
    fetchLeads();
    _lostCustomersDatabase.getAllContacts();
  }

  pressEditBtn(ContactInfoModel contact) {
    updateScreenValue(contact);
    Get.toNamed(Routes.addNewContactScreen);
  }

  updateScreenValue(ContactInfoModel contact) {
    bool exist = Get.isRegistered<NewContactsController>();
    if (exist == true) {
      updateTxtFildValu(contact);
    } else {
      Get.put(NewContactsController());
      updateTxtFildValu(contact);
    }
  }

  updateTxtFildValu(ContactInfoModel contact) {
    NewContactsController().instance.name.text = contact.name;
    NewContactsController().instance.identification.text =
        contact.identification!;

    if (NewContactsController().instance.showPhoneField.value == true) {
      NewContactsController().instance.phone.text = contact.phone!;
    }
    if (NewContactsController().instance.showEmailField.value == true) {
      NewContactsController().instance.email.text = contact.email!;
    }
    if (NewContactsController().instance.showAddinform.value == true) {
      NewContactsController().instance.additionalInformation.text =
          contact.additionalInformation!;
    }
  }

  @override
  void onInit() {
    fetchLeads();
    super.onInit();
  }
}
