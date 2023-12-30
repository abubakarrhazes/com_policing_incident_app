import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PoliceStation {
  String? id;
  final String name;
  final String address;
  final String telephone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PoliceStation({
    this.id,
    required this.name,
    required this.address,
    required this.telephone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PoliceStation.fromJson(Map<String, dynamic> json) {
    return PoliceStation(
        id: json['_id'] as String,
        name: json['name'] as String,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
        address: json['address'] as String,
        telephone: json['telephone'] as String);
  }
}
