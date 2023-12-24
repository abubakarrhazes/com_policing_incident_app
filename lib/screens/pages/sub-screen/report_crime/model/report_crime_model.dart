// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportCrimeModel {
  final String category;
  final String details;
  final String? photo;
  final String? video;
  final String? audio;
  final String? file;
  final String policeUnit;
  final UserLoc location;

  ReportCrimeModel({
    required this.category,
    required this.details,
    this.photo,
    this.video,
    this.audio,
    this.file,
    required this.policeUnit,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'details': details,
      'photo': photo,
      'video': video,
      'audio': audio,
      'file': file,
      'policeUnit': policeUnit,
      'location': location.toMap(),
    };
  }

  factory ReportCrimeModel.fromMap(Map<String, dynamic> map) {
    return ReportCrimeModel(
      category: map['category'] as String,
      details: map['details'] as String,
      photo: map['photo'] != null ? map['photo'] as String : null,
      video: map['video'] != null ? map['video'] as String : null,
      audio: map['audio'] != null ? map['audio'] as String : null,
      file: map['file'] != null ? map['file'] as String : null,
      policeUnit: map['policeUnit'] as String,
      location:
          UserLoc.fromMap(map['location'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportCrimeModel.fromJson(String source) =>
      ReportCrimeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserLoc {
  double latitude;
  double logitude;
  UserLoc({
    required this.latitude,
    required this.logitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'logitude': logitude,
    };
  }

  factory UserLoc.fromMap(Map<String, dynamic> map) {
    return UserLoc(
      latitude: map['latitude'] as double,
      logitude: map['logitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoc.fromJson(String source) =>
      UserLoc.fromMap(json.decode(source) as Map<String, dynamic>);
}
