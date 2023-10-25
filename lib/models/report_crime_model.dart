// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportCrimeModel {
  String user;
  String category;
  String ref;
  String details;
  String status;
  String policeUnit;
  Location location;
  String id;

  ReportCrimeModel({
    required this.user,
    required this.category,
    required this.ref,
    required this.details,
    required this.status,
    required this.policeUnit,
    required this.location,
    required this.id,
  });

  toJson() {}
}

class Location {
  String latitude;
  String logitude;

  Location({
    required this.latitude,
    required this.logitude,
  });
}
