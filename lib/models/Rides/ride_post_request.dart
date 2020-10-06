// To parse this JSON data, do
//
//     final ridePost = ridePostFromJson(jsonString);

import 'dart:convert';

RidePost ridePostFromJson(String str) => RidePost.fromJson(json.decode(str));

String ridePostToJson(RidePost data) => json.encode(data.toJson());

class RidePost {
  RidePost({
    this.latitudeStart,
    this.longitudeStart,
    this.addressStart,
    this.longitudeFinish,
    this.latitudeFinish,
    this.addressFinish,
    this.startAt,
    this.endAt,
    this.date,
  });

  final double latitudeStart;
  final double longitudeStart;
  final String addressStart;
  final double longitudeFinish;
  final double latitudeFinish;
  final String addressFinish;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime date;

  RidePost copyWith({
    double latitudeStart,
    double longitudeStart,
    String addressStart,
    double longitudeFinish,
    double latitudeFinish,
    String addressFinish,
    DateTime startAt,
    DateTime endAt,
    DateTime date,
  }) =>
      RidePost(
        latitudeStart: latitudeStart ?? this.latitudeStart,
        longitudeStart: longitudeStart ?? this.longitudeStart,
        addressStart: addressStart ?? this.addressStart,
        longitudeFinish: longitudeFinish ?? this.longitudeFinish,
        latitudeFinish: latitudeFinish ?? this.latitudeFinish,
        addressFinish: addressFinish ?? this.addressFinish,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        date: date ?? this.date,
      );

  factory RidePost.fromJson(Map<String, dynamic> json) => RidePost(
        latitudeStart: json["latitude_start"] == null ? null : json["latitude_start"].toDouble(),
        longitudeStart: json["longitude_start"] == null ? null : json["longitude_start"].toDouble(),
        addressStart: json["address_start"] == null ? null : json["address_start"],
        longitudeFinish: json["longitude_finish"] == null ? null : json["longitude_finish"].toDouble(),
        latitudeFinish: json["latitude_finish"] == null ? null : json["latitude_finish"].toDouble(),
        addressFinish: json["address_finish"] == null ? null : json["address_finish"],
        startAt: json["start_at"] == null ? null : DateTime.parse(json["start_at"]),
        endAt: json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude_start": latitudeStart == null ? null : latitudeStart,
        "longitude_start": longitudeStart == null ? null : longitudeStart,
        "address_start": addressStart == null ? null : addressStart,
        "longitude_finish": longitudeFinish == null ? null : longitudeFinish,
        "latitude_finish": latitudeFinish == null ? null : latitudeFinish,
        "address_finish": addressFinish == null ? null : addressFinish,
        "start_at": startAt == null ? null : startAt.toIso8601String(),
        "end_at": endAt == null ? null : endAt.toIso8601String(),
        "date": date == null ? null : date.toIso8601String(),
      };
}
