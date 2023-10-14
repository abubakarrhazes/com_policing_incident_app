// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReportIncidentModel {
  final String category;
  final String details;
  final String? media;
  final String location;
  final String station;
  ReportIncidentModel({
    required this.category,
    required this.details,
    this.media,
    required this.location,
    required this.station,
  });

  ReportIncidentModel copyWith({
    String? category,
    String? details,
    String? media,
    String? location,
    String? station,
  }) {
    return ReportIncidentModel(
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

  factory ReportIncidentModel.fromMap(Map<String, dynamic> map) {
    return ReportIncidentModel(
      category: map['category'] as String,
      details: map['details'] as String,
      media: map['media'] != null ? map['media'] as String : null,
      location: map['location'] as String,
      station: map['station'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportIncidentModel.fromJson(String source) =>
      ReportIncidentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportIncidentModel(category: $category, details: $details, media: $media, location: $location, station: $station)';
  }

  @override
  bool operator ==(covariant ReportIncidentModel other) {
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
