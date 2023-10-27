// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String otherName;
  final String DOB;
  final String email;
  final String officeAddress;
  final String? profilePicture;
  final String phoneNumber;
  final String occupation;
  final String password;
  final String state;
  final String? role;
  final String? accessToken;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.DOB,
    required this.email,
    required this.officeAddress,
    this.profilePicture,
    required this.phoneNumber,
    required this.occupation,
    required this.password,
    required this.state,
    this.role,
    this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, String>{
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'otherName': otherName,
      'DOB': DOB,
      'email': email,
      'officeAddress': officeAddress,
      'profilePicture': profilePicture!,
      'phoneNumber': phoneNumber,
      'occupation': occupation,
      'password': password,
      'state': state,
      'role': role!,
      'accessToken': accessToken!,
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
      officeAddress: map['officeAddress'] as String,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
      phoneNumber: map['phoneNumber'] as String,
      occupation: map['occupation'] as String,
      password: map['password'] as String,
      state: map['state'] as String,
      role: map['role'] != null ? map['role'] as String : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? otherName,
    String? DOB,
    String? email,
    String? officeAddress,
    String? profilePicture,
    String? phoneNumber,
    String? occupation,
    String? password,
    String? state,
    String? role,
    String? accessToken,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      otherName: otherName ?? this.otherName,
      DOB: DOB ?? this.DOB,
      email: email ?? this.email,
      officeAddress: officeAddress ?? this.officeAddress,
      profilePicture: profilePicture ?? this.profilePicture,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      occupation: occupation ?? this.occupation,
      password: password ?? this.password,
      state: state ?? this.state,
      role: role ?? this.role,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, otherName: $otherName, DOB: $DOB, email: $email, officeAddress: $officeAddress, profilePicture: $profilePicture, phoneNumber: $phoneNumber, occupation: $occupation, password: $password, state: $state, role: $role, accessToken: $accessToken)';
  }
}
