class SearchModel {
  int status;
  String message;
  SearchModelData data;

  SearchModel(
      {required this.status, required this.message, required this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json['status'],
      message: json['message'],
      data: SearchModelData.fromJson(json['data']),
    );
  }
}

class SearchModelData {
  Location location;
  String id;
  String user;
  String category;
  String ref;
  String details;
  String status;
  String policeUnit;
  String address;
  String photo;
  dynamic video;
  dynamic audio;
  dynamic file;
  String createdAt;
  String updatedAt;
  int v;

  SearchModelData({
    required this.location,
    required this.id,
    required this.user,
    required this.category,
    required this.ref,
    required this.details,
    required this.status,
    required this.policeUnit,
    required this.address,
    required this.photo,
    required this.video,
    required this.audio,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SearchModelData.fromJson(Map<String, dynamic> json) {
    return SearchModelData(
      location: Location.fromJson(json['location']),
      id: json['_id'],
      user: json['user'],
      category: json['category'],
      ref: json['ref'],
      details: json['details'],
      status: json['status'],
      policeUnit: json['policeUnit'],
      address: json['address'],
      photo: json['photo'],
      video: json['video'],
      audio: json['audio'],
      file: json['file'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class Location {
  String latitude;
  String logitude;

  Location({required this.latitude, required this.logitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      logitude: json['logitude'],
    );
  }
}
