// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportCrimeModel {
  final String category;
  final String details;
  final media;
  final String location;
  final String station;
  ReportCrimeModel({
    required this.category,
    required this.details,
    this.media,
    required this.location,
    required this.station,
  });

  ReportCrimeModel copyWith({
    String? category,
    String? details,
    String? media,
    String? location,
    String? station,
  }) {
    return ReportCrimeModel(
      category: category ?? this.category,
      details: details ?? this.details,
      media: media ?? this.media,
      location: location ?? this.location,
      station: station ?? this.station,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'details': details,
      'media': media,
      'location': location,
      'station': station,
    };
  }

  factory ReportCrimeModel.fromMap(Map<String, dynamic> map) {
    return ReportCrimeModel(
      category: map['category'] as String,
      details: map['details'] as String,
      media: map['media'] != null ? map['media'] as String : null,
      location: map['location'] as String,
      station: map['station'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportCrimeModel.fromJson(String source) =>
      ReportCrimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportCrimeModel(category: $category, details: $details, media: $media, location: $location, station: $station)';
  }

  @override
  bool operator ==(covariant ReportCrimeModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.details == details &&
        other.media == media &&
        other.location == location &&
        other.station == station;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        details.hashCode ^
        media.hashCode ^
        location.hashCode ^
        station.hashCode;
  }
}
