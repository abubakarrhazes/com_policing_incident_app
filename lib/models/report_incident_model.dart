// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportIncidentModel {
  String category;
  String details;
  String policeUnit;
  UserLocationData location;
  List<dynamic>? file = [];

  ReportIncidentModel({
    required this.category,
    required this.details,
    required this.policeUnit,
    required this.location,
    this.file,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'details': details,
      'policeUnit': policeUnit,
      'location': location.toMap(),
      'file': file,
    };
  }

  factory ReportIncidentModel.fromMap(Map<String, dynamic> map) {
    return ReportIncidentModel(
      category: map['category'] as String,
      details: map['details'] as String,
      policeUnit: map['policeUnit'] as String,
      location:
          UserLocationData.fromMap(map['location'] as Map<String, dynamic>),
      file: map['file'] != null
          ? List<String>.from(map['file'] as List<dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportIncidentModel.fromJson(String source) =>
      ReportIncidentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserLocationData {
  double latitude;
  double logitude;
  UserLocationData({
    required this.latitude,
    required this.logitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'logitude': logitude,
    };
  }

  factory UserLocationData.fromMap(Map<String, dynamic> map) {
    return UserLocationData(
      latitude: map['latitude'] as double,
      logitude: map['logitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLocationData.fromJson(String source) =>
      UserLocationData.fromMap(json.decode(source) as Map<String, dynamic>);
}
