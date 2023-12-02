import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForgotPasswordModel {
  final String email;

  ForgotPasswordModel({
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory ForgotPasswordModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordModel(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordModel.fromJson(String source) =>
      ForgotPasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
