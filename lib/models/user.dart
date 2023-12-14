// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, constant_pattern_never_matches_value_type
import 'dart:convert';

import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String otherName;
  final String DOB;
  final String email;
  final String? address;
  final String? profilePicture;
  final String phoneNumber;
  final String occupation;
  final String state;
  final String? roles;
  final String? accessToken;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.DOB,
    required this.email,
    required this.address,
    this.profilePicture,
    required this.phoneNumber,
    required this.occupation,
    required this.state,
    this.roles,
    this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
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
      'roles': roles,
      'accessToken': accessToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      otherName: map['otherName'] as String,
      DOB: map['DOB'] as String,
      email: map['email'] as String,
      address: map['address'] as String?,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,

      // TODO: phoneNumber should be String
      // phoneNumber: map['phoneNumber'] as String,
      phoneNumber: map['phoneNumber'].toString(),
      occupation: map['occupation'] as String,
      state: map['state'] as String,
      roles: map['roles'] != null ? map['roles'] as String : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
  /*

  static UserRoles _mapStringToUserRole(String role) {
    switch (role) {
      case 'user':
        return UserRoles.user;
      case 'policeStation':
        return UserRoles.policeStation;
      case 'admin':
        return UserRoles.admin;
      default:
        throw ArgumentError('Invalid role: $role');
    }
  }
  */
}
