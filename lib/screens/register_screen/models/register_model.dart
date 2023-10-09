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

  RegisterModel copyWith({
    String? firstName,
    String? lastName,
    String? otherName,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
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
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      state: state ?? this.state,
      occupation: occupation ?? this.occupation,
      address: address ?? this.address,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'RegisterModel(firstName: $firstName, lastName: $lastName, otherName: $otherName, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, state: $state, occupation: $occupation, address: $address, password: $password)';
  }

  @override
  bool operator ==(covariant RegisterModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.otherName == otherName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.dateOfBirth == dateOfBirth &&
        other.state == state &&
        other.occupation == occupation &&
        other.address == address &&
        other.password == password;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        otherName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        dateOfBirth.hashCode ^
        state.hashCode ^
        occupation.hashCode ^
        address.hashCode ^
        password.hashCode;
  }
}
