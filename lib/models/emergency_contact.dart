// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
import 'dart:convert';

class EmergencyContact {
  int? status;
  String? message;
  List<Data>? data;

  EmergencyContact({this.status, this.message, this.data});

  EmergencyContact.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? id;
  String? user;
  String? name;
  String? mobileNumber;
  String? email;
  String? relation;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data(
      {this.id,
      this.user,
      this.name,
      this.mobileNumber,
      this.email,
      this.relation,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.v});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    user = json["user"];
    name = json["name"];
    mobileNumber = json["mobileNumber"].toString();
    email = json["email"];
    relation = json["relation"];
    address = json["address"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["user"] = user;
    _data["name"] = name;
    _data["mobileNumber"] = mobileNumber.toString();
    _data["email"] = email;
    _data["relation"] = relation;
    _data["address"] = address;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
