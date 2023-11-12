// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class RegisterModel {
  String firstName;
  String lastName;
  String otherName;
  String email;
  String? profilePicture;
  String phoneNumber;
  String DOB;
  String state;
  String occupation;
  String address;
  String password;

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.email,
    this.profilePicture,
    required this.phoneNumber,
    required this.DOB,
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
      'profilePicture': profilePicture,
      'phoneNumber': phoneNumber,
      'DOB': DOB,
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
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
      phoneNumber: map['phoneNumber'] as String,
      DOB: map['DOB'] as String,
      state: map['state'] as String,
      occupation: map['occupation'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterModel(firstName: $firstName, lastName: $lastName, otherName: $otherName, email: $email, profilePicture: $profilePicture, phoneNumber: $phoneNumber, DOB: $DOB, state: $state, occupation: $occupation, address: $address, password: $password)';
  }

  RegisterModel copyWith({
    String? firstName,
    String? lastName,
    String? otherName,
    String? email,
    String? profilePicture,
    String? phoneNumber,
    String? DOB,
    String? state,
    String? occupation,
    String? address,
    String? password,
  }) {
    return RegisterModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      otherName: otherName ?? this.otherName,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      DOB: DOB ?? this.DOB,
      state: state ?? this.state,
      occupation: occupation ?? this.occupation,
      address: address ?? this.address,
      password: password ?? this.password,
    );
  }
}
