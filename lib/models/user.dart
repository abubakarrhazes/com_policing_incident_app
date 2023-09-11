class User {
  final String userId;
  final String firstName;
  final String lastName;
  final String otherName;
  final String? dateOfBirth;
  final String email;
  final String? address;
  final String? ninNumber;
  final String phoneNumber;
  final String password;
  final String passwordComfirmation;
  final String? stateOfOrigin;
  final String userRole;
  final String token;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.dateOfBirth,
    required this.email,
    required this.address,
    required this.ninNumber,
    required this.phoneNumber,
    required this.password,
    required this.stateOfOrigin,
    required this.passwordComfirmation,
    required this.userRole,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'firstname': firstName,
      'lastname': lastName,
      'othername': otherName,
      'email': email,
      'address': address,
      'nin_number': ninNumber,
      'phone_number': phoneNumber,
      'password': password,
      'password_comfirmation': passwordComfirmation,
      'user_role': userRole,
      'token': token,
    };
  }
}
