// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  final String firstName;
  final String lastName;
  final String otherName;
  final String DOB;
  final String email;
  final String address;
  final String? profilePicture;
  final String phoneNumber;
  final String occupation;
  final String state;
  final String password;
  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.DOB,
    required this.email,
    required this.address,
    required this.profilePicture,
    required this.phoneNumber,
    required this.occupation,
    required this.state,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'otherName': otherName,
      'DOB': DOB,
      'email': email,
      'address': address,
      'profilePicture': profilePicture,
      'phoneNumber': phoneNumber,
      'occupation': occupation,
      'state': state,
      'password': password,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      otherName: map['otherName'] as String,
      DOB: map['DOB'] as String,
      email: map['email'] as String,
      address: map['officeAddress'] as String,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
      // TODO: phoneNumber should be String
      // phoneNumber: map['phoneNumber'] as String,
      phoneNumber: map['phoneNumber'].toString(),
      occupation: map['occupation'] as String,
      state: map['state'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
