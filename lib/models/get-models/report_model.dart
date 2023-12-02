import 'dart:convert';

class ReportModels {
  final int status;
  final String message;
  final ReportData data;

  ReportModels(
      {required this.status, required this.message, required this.data});

  factory ReportModels.fromJson(Map<String, dynamic> json) {
    return ReportModels(
      status: json['status'],
      message: json['message'],
      data: ReportData.fromJson(json['data']),
    );
  }
}

class ReportData {
  final String user;
  final String category;
  final String ref;
  final String details;
  final String status;
  final String policeUnit;
  final Location? location;
  final UploadPhoto?
      photo; // You can replace "dynamic" with the actual type if needed
  final UploadVideo? video;
  final UploadAudio? audio;
  final UploadFile? file;
  final String id;
  final String createdAt;
  final String updatedAt;

  ReportData({
    required this.user,
    required this.category,
    required this.ref,
    required this.details,
    required this.status,
    required this.policeUnit,
    required this.location,
    this.photo,
    this.video,
    this.audio,
    this.file,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      user: json['user'],
      category: json['category'],
      ref: json['ref'],
      details: json['details'],
      status: json['status'],
      policeUnit: json['policeUnit'],
      location: Location.fromJson(json['location']),
      photo: UploadPhoto.fromMap(json['photo'] as Map<String, dynamic>),
      video: UploadVideo.fromMap(json['video'] as Map<String, dynamic>),
      audio: UploadAudio.fromMap(json['audio'] as Map<String, dynamic>),
      file: UploadFile.fromMap(json['file'] as Map<String, dynamic>),
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Location {
  final String latitude;
  final String longitude;

  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class UploadPhoto {
  String? public_id;
  String? format;
  String? url;
  UploadPhoto({
    this.public_id,
    this.format,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'public_id': public_id,
      'format': format,
      'url': url,
    };
  }

  factory UploadPhoto.fromMap(Map<String, dynamic> map) {
    return UploadPhoto(
      public_id: map['public_id'] != null ? map['public_id'] as String : null,
      format: map['format'] != null ? map['format'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadPhoto.fromJson(String source) =>
      UploadPhoto.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UploadVideo {
  String? public_id;
  String? format;
  String? url;
  UploadVideo({
    this.public_id,
    this.format,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'public_id': public_id,
      'format': format,
      'url': url,
    };
  }

  factory UploadVideo.fromMap(Map<String, dynamic> map) {
    return UploadVideo(
      public_id: map['public_id'] != null ? map['public_id'] as String : null,
      format: map['format'] != null ? map['format'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadVideo.fromJson(String source) =>
      UploadVideo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UploadAudio {
  String? public_id;
  String? format;
  String? url;
  UploadAudio({
    this.public_id,
    this.format,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'public_id': public_id,
      'format': format,
      'url': url,
    };
  }

  factory UploadAudio.fromMap(Map<String, dynamic> map) {
    return UploadAudio(
      public_id: map['public_id'] != null ? map['public_id'] as String : null,
      format: map['format'] != null ? map['format'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadAudio.fromJson(String source) =>
      UploadAudio.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UploadFile {
  String? public_id;
  String? format;
  String? url;
  UploadFile({
    this.public_id,
    this.format,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'public_id': public_id,
      'format': format,
      'url': url,
    };
  }

  factory UploadFile.fromMap(Map<String, dynamic> map) {
    return UploadFile(
      public_id: map['public_id'] != null ? map['public_id'] as String : null,
      format: map['format'] != null ? map['format'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadFile.fromJson(String source) =>
      UploadFile.fromMap(json.decode(source) as Map<String, dynamic>);
}
