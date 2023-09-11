class RegisterModel {
  String firstName;
  String lastName;
  String otherName;
  String email;
  String phoneNumber;
  String password;

  String passwordComfirmation;

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.passwordComfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'othername': otherName,
      'phone_number': phoneNumber,
      'password': password,
      'password_comfirmation': passwordComfirmation,
    };
  }
}
