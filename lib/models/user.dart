// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String otherName;
  final String? dateOfBirth;
  final String email;
  final String? address;
  final String? ninNumber;
  final String phoneNumber;
  final String occupation;
  final String password;
  final String? state;
  final String? userRole;
  final String? token;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.dateOfBirth,
    required this.email,
    required this.address,
    required this.ninNumber,
    required this.phoneNumber,
    required this.occupation,
    required this.password,
    required this.state,
    required this.userRole,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'otherName': otherName,
      'email': email,
      'address': address,
      'ninNumber': ninNumber,
      'phoneNumber': phoneNumber,
      'password': password,
      'stateOfOrigin': state,
      'userRole': userRole,
      'token': token,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'otherName': otherName,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'address': address,
      'ninNumber': ninNumber,
      'phoneNumber': phoneNumber,
      'occupation': occupation,
      'password': password,
      'state': state,
      'userRole': userRole,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      otherName: map['otherName'] as String,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      email: map['email'] as String,
      address: map['address'] != null ? map['address'] as String : null,
      ninNumber: map['ninNumber'] != null ? map['ninNumber'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
      occupation: map['occupation'] as String,
      password: map['password'] as String,
      state: map['state'] != null ? map['state'] as String : null,
      userRole: map['userRole'] as String,
      token: map['token'] as String,
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? otherName,
    String? dateOfBirth,
    String? email,
    String? address,
    String? ninNumber,
    String? phoneNumber,
    String? occupation,
    String? password,
    String? state,
    String? userRole,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      otherName: otherName ?? this.otherName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      address: address ?? this.address,
      ninNumber: ninNumber ?? this.ninNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      occupation: occupation ?? this.occupation,
      password: password ?? this.password,
      state: state ?? this.state,
      userRole: userRole ?? this.userRole,
      token: token ?? this.token,
    );
  }

  //String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, otherName: $otherName, dateOfBirth: $dateOfBirth, email: $email, address: $address, ninNumber: $ninNumber, phoneNumber: $phoneNumber, occupation: $occupation, password: $password, state: $state, userRole: $userRole, token: $token)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.otherName == otherName &&
        other.dateOfBirth == dateOfBirth &&
        other.email == email &&
        other.address == address &&
        other.ninNumber == ninNumber &&
        other.phoneNumber == phoneNumber &&
        other.occupation == occupation &&
        other.password == password &&
        other.state == state &&
        other.userRole == userRole &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        otherName.hashCode ^
        dateOfBirth.hashCode ^
        email.hashCode ^
        address.hashCode ^
        ninNumber.hashCode ^
        phoneNumber.hashCode ^
        occupation.hashCode ^
        password.hashCode ^
        state.hashCode ^
        userRole.hashCode ^
        token.hashCode;
  }
}
