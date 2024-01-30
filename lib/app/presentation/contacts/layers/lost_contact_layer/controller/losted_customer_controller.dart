// leaded_customer_controller.dart

import 'package:salesman/app/presentation/contacts/layers/customer_layer/controller/customer_controller.dart';
import 'package:salesman/app/presentation/contacts/layers/leads_layer/controller/leads_controller.dart';
import 'package:salesman/app/service/database/lost_customer_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../service/database/customer_database.dart';
import '../../../../../service/database/leads_database.dart';
import '../../../model/contact_info_model.dart';
import '../../../../../widget/snak_bar.dart';

class LostedCustomerController extends GetxController {
  LostedCustomerController get instance => Get.find();

  final LeadsDatabase _leadsDatabase = LeadsDatabase();
  final LostedCustomersDatabase _lostCustomersDatabase =
      LostedCustomersDatabase();
  final CustomersDatabase _customersDatabase = CustomersDatabase();

  RxBool fetchData = false.obs;
  late TabController tabBarController;
  final RxList<ContactInfoModel> leads = <ContactInfoModel>[].obs;

  Future<void> fetchLeads() async {
    leads.value = await _lostCustomersDatabase.getAllContacts();
  }

  Future<void> removeLeads(int id) async {
    await _lostCustomersDatabase.removeLostedCustomer(id);
  }

  Future<void> moveToCustomer(ContactInfoModel contact) async {
    await _customersDatabase.insertCustomer(contact);
    CustomerController().instance.fetchLeads();
    await _lostCustomersDatabase.removeLostedCustomer(contact.uId!);
    leads.clear();
  }

  Future<void> moveToLead(ContactInfoModel contact) async {
    await _leadsDatabase.insertContact(contact);
    LeadController().instance.fetchLeads();
    await _lostCustomersDatabase.removeLostedCustomer(contact.uId!);
    leads.clear();
  }

  void pressMoveToLead(ContactInfoModel contact) async {
    await moveToLead(contact);
    leads.clear();
    showCustomSnackBar('تم نقل جهة الاتصال بنجاح', isError: false);
    fetchLeads();
    _leadsDatabase.getAllContacts();
  }

  void pressMoveToCustomer(ContactInfoModel contact) async {
    await moveToCustomer(contact);
    leads.clear();
    showCustomSnackBar('تم نقل جهة الاتصال بنجاح', isError: false);
    fetchLeads();
    _customersDatabase.getAllContacts();
    Get.back();
  }

  void pressRemove(int id) async {
    leads.clear();
    await removeLeads(id);
    showCustomSnackBar('تم حذف جهة الاتصال بنجاح');
    fetchLeads();
  }

  @override
  void onInit() {
    fetchLeads();
    super.onInit();
  }
}
