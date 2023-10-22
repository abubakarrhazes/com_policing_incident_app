// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterModel {
  String firstName;
  String lastName;
  String otherName;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String state;
  String occupation;
  String address;
  String password;

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.state,
    required this.occupation,
    required this.address,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'otherName': otherName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'state': state,
      'occupation': occupation,
      'address': address,
      'password': password,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      otherName: map['otherName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      state: map['state'] as String,
      occupation: map['occupation'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
