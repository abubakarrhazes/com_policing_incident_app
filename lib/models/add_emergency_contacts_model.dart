// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddEmergencyContactsModel {
  final String firstName;
  final String phoneNumber;
  final String email;
  final String relation;
  final String address;

  AddEmergencyContactsModel({
    required this.firstName,
    required this.phoneNumber,
    required this.email,
    required this.relation,
    required this.address,
  });

  AddEmergencyContactsModel copyWith({
    String? firstName,
    String? phoneNumber,
    String? email,
    String? relation,
    String? address,
  }) {
    return AddEmergencyContactsModel(
      firstName: firstName ?? this.firstName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      relation: relation ?? this.relation,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'phoneNumber': phoneNumber,
      'email': email,
      'relation': relation,
      'address': address,
    };
  }

  factory AddEmergencyContactsModel.fromMap(Map<String, dynamic> map) {
    return AddEmergencyContactsModel(
      firstName: map['firstName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      relation: map['relation'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddEmergencyContactsModel.fromJson(String source) =>
      AddEmergencyContactsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddEmergencyContactsModel(firstName: $firstName, phoneNumber: $phoneNumber, email: $email, relation: $relation, address: $address)';
  }

  @override
  bool operator ==(covariant AddEmergencyContactsModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.relation == relation &&
        other.address == address;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        relation.hashCode ^
        address.hashCode;
  }
}
