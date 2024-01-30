import 'package:salesman/app/presentation/contacts/layers/customer_layer/controller/customer_controller.dart';
import 'package:salesman/app/presentation/contacts/layers/lost_contact_layer/controller/losted_customer_controller.dart';
import 'package:salesman/app/presentation/contacts/layers/add_new_contact/controller/new_contact_controller.dart';
import 'package:salesman/app/service/database/customer_database.dart';
import 'package:salesman/app/service/database/lost_customer_database.dart';
import 'package:salesman/app/widget/snak_bar.dart';
import 'package:salesman/app/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../service/database/leads_database.dart';
import '../../../model/contact_info_model.dart';

class LeadController extends GetxController {
  LeadController get instance => Get.find();
  final LeadsDatabase _leadsDatabase = LeadsDatabase();
  final LostedCustomersDatabase _lostCustomersDatabase =
      LostedCustomersDatabase();
  final CustomersDatabase _customersDatabase = CustomersDatabase();
  RxBool featchData = false.obs;
  late TabController tapBarController;
  final RxList<ContactInfoModel> leads = <ContactInfoModel>[].obs;

  Future<void> fetchLeads() async {
    leads.value = await _leadsDatabase.getAllContacts();
  }

  Future<void> removeLeads(int id) async {
    await _leadsDatabase.removeContact(id);
  }

  Future<void> moveToLost(ContactInfoModel contact) async {
    await _lostCustomersDatabase.insertLostedCustomer(contact);
    LostedCustomerController().fetchLeads();
    await _leadsDatabase.removeContact(contact.uId!);
    fetchLeads();
  }

  Future<void> moveToCustomer(ContactInfoModel contact) async {
    await _customersDatabase.insertCustomer(contact);
    CustomerController().instance.fetchLeads();
    await _leadsDatabase.removeContact(contact.uId!);
    fetchLeads();
  }

  void pressRemove(int id) async {
    leads.clear();
    await removeLeads(id);
    showCustomSnackBar('تم حذف جهة الاتصال بنجاح');
    fetchLeads();
  }

  void pressMoveToLost(ContactInfoModel contact) async {
    await moveToLost(contact);
    showCustomSnackBar('تم نقل جهة الاتصال بنجاح', isError: false);
    fetchLeads();
    _lostCustomersDatabase.getAllContacts();
  }

  void pressMoveToCustomer(ContactInfoModel contact) async {
    await moveToCustomer(contact);
    showCustomSnackBar('تم نقل جهة الاتصال بنجاح', isError: false);
    fetchLeads();
    _customersDatabase.getAllContacts();
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
