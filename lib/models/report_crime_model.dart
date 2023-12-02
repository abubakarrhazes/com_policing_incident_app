// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:convert';
import 'dart:io';

class ReportCrimeModel {
  String category;
  String details;
  String policeUnit;
  final UserLocationData location;
  final String photo;
  final String? video;
  final String? audio;
  final String? file;

  ReportCrimeModel({
    required this.category,
    required this.details,
    required this.policeUnit,
    required this.location,
    required this.photo,
    this.video,
    this.audio,
    this.file,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'details': details,
      'policeUnit': policeUnit,
      'location': location.toJson(),
    };
  }

  factory ReportCrimeModel.fromMap(Map<String, dynamic> map) {
    return ReportCrimeModel(
      category: map['category'] as String,
      details: map['details'] as String,
      policeUnit: map['policeUnit'] as String,
      location:
          UserLocationData.fromMap(map['location'] as Map<String, dynamic>),
      photo: map['photo'] as String,
      video: map['video'] != null ? map['video'] as String : null,
      audio: map['audio'] != null ? map['audio'] as String : null,
      file: map['file'] != null ? map['file'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportCrimeModel.fromJson(String source) =>
      ReportCrimeModel.fromMap(json.decode(source) as Map<String, dynamic>);
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
