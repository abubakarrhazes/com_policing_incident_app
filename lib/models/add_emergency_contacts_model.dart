// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddEmergencyContactsModel {
  final String name;
  final String mobileNumber;
  final String email;
  final String relation;
  final String address;

  AddEmergencyContactsModel({
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.relation,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
      'relation': relation,
      'address': address,
    };
  }

  factory AddEmergencyContactsModel.fromMap(Map<String, dynamic> map) {
    return AddEmergencyContactsModel(
      name: map['name'] as String,
      mobileNumber: map['mobileNumber'] as String,
      email: map['email'] as String,
      relation: map['relation'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddEmergencyContactsModel.fromJson(String source) =>
      AddEmergencyContactsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
