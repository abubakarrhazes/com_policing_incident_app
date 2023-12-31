// ignore_for_file: public_member_api_docs, sort_constructors_first
class Police {
  int? status;
  String? message;
  List<Data>? data;

  Police({this.status, this.message, this.data});

  Police.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? address;
  String? telephone;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data({
    this.id,
    this.name,
    this.address,
    this.telephone,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    address = json['address'];
    telephone = json['telephone'];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["address"] = address;
    _data["telephone"] = telephone;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
