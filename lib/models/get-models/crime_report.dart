// ignore_for_file: no_leading_underscores_for_local_identifiers

class CrimeReport {
  int? status;
  String? message;
  List<CrimeData>? data;

  CrimeReport({this.status, this.message, this.data});

  CrimeReport.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => CrimeData.fromJson(e)).toList();
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

class CrimeData {
  UserLocation? location;
  String? id;
  dynamic user;
  String? category;
  String? ref;
  String? details;
  String? status;
  String? policeUnit;
  String? image;
  String? video;
  String? audio;
  String? file;
  String? createdAt;
  String? updatedAt;
  String? address;
  int? v;

  CrimeData(
      {this.location,
      this.id,
      this.user,
      this.category,
      this.ref,
      this.details,
      this.status,
      this.policeUnit,
      this.image,
      this.video,
      this.audio,
      this.file,
      this.createdAt,
      this.updatedAt,
      this.address,
      this.v});

  CrimeData.fromJson(Map<String, dynamic> json) {
    location = json["location"] == null
        ? null
        : UserLocation.fromJson(json["location"]);
    id = json["_id"];
    user = json["user"];
    category = json["category"];
    ref = json["ref"];
    details = json["details"];
    status = json["status"];
    policeUnit = json["policeUnit"];
    image = json["image"];
    video = json["video"];
    audio = json["audio"];
    file = json["file"];
    address = json["address"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (location != null) {
      _data["location"] = location?.toJson();
    }
    _data["_id"] = id;
    _data["user"] = user;
    _data["category"] = category;
    _data["ref"] = ref;
    _data["details"] = details;
    _data["status"] = status;
    _data["policeUnit"] = policeUnit;
    _data["image"] = image;
    _data["video"] = video;
    _data["audio"] = audio;
    _data["file"] = file;
    _data["address"] = address;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class UserLocation {
  String? latitude;
  String? logitude;

  UserLocation({this.latitude, this.logitude});

  UserLocation.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    logitude = json["logitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["logitude"] = logitude;
    return _data;
  }
}
