import 'package:salesman/app/views/contacts/controller/customer_controller.dart';
import 'package:salesman/app/service/database/customer_database.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../service/database/leads_database.dart';
import '../model/contact_info_model.dart';
import '../../../widget/snak_bar.dart';
import 'leads_controller.dart';

class NewContactsController extends GetxController {
  NewContactsController get instance => Get.find();
  final LeadsDatabase _leadsDatabase = LeadsDatabase();
  final CustomersDatabase _customersDatabase = CustomersDatabase();
  TextEditingController identification = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController additionalInformation = TextEditingController();
  RxBool showEmailField = false.obs;
  RxBool showAddinform = false.obs;
  RxBool showPhoneField = false.obs;
  RxString title = ''.obs;
  RxBool leads = false.obs;
  RxBool customer = false.obs;

  Future<void> saveInDataBase(ContactInfoModel contact) async {
    if (leads.value == true) {
      await _leadsDatabase.insertContact(contact);
      await LeadController().instance.fetchLeads();
    } else {
      await _customersDatabase.insertCustomer(contact);
      await CustomerController().instance.fetchLeads();
    }
  }

  Future<void> saveContact() async {
    ContactInfoModel contact = ContactInfoModel(
      identification: identification.text,
      name: name.text,
      phone: phone.text,
      email: email.text,
      additionalInformation: additionalInformation.text,
    );

    if (name.text.isNotEmpty && phone.text.isNotEmpty) {
      await saveInDataBase(contact).then((value) async {
        showCustomSnackBar('تم الحفظ بنجاح', isError: false);
        clearTextFields();
      });
    } else {
      showCustomSnackBar('أدخل البيانات اولاً');
    }
  }

  void clearTextFields() {
    identification.clear();
    name.clear();
    phone.clear();
    email.clear();
    additionalInformation.clear();
  }

  void toShowEmailField() {
    showEmailField.toggle();
    email.clear();
  }

  void toshowPhoneField() {
    showPhoneField.toggle();
    phone.clear();
  }

  void toshowAdditionalInformationField() {
    showAddinform.toggle();
    additionalInformation.clear();
  }
}
