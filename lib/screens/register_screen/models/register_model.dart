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
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'otherName': otherName,
      'phoneNumber': phoneNumber,
      'password': password,
      'passwordcomfirmation': passwordComfirmation,
    };
  }
}
