class ContactInfoModel {
  int? uId;
  String? identification;
  String name;
  String? phone;
  String? email;
  String? additionalInformation;

  ContactInfoModel({
    this.uId,
    required this.identification,
    required this.name,
    required this.phone,
    required this.email,
    required this.additionalInformation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': uId,
      'identification': identification ?? '',
      'name': name,
      'phone': phone ?? '',
      'email': email ?? '',
      'additionalInformation': additionalInformation ?? '',
    };
  }
}
