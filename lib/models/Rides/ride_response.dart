// To parse this JSON data, do
//
//     final rideResponse = rideResponseFromJson(jsonString);

import 'dart:convert';

RideResponse rideResponseFromJson(String str) => RideResponse.fromJson(json.decode(str));

String rideResponseToJson(RideResponse data) => json.encode(data.toJson());

class RideResponse {
  RideResponse({
    this.message,
    this.ride,
  });

  final String message;
  final Ride ride;

  RideResponse copyWith({
    String message,
    Ride ride,
  }) =>
      RideResponse(
        message: message ?? this.message,
        ride: ride ?? this.ride,
      );

  factory RideResponse.fromJson(Map<String, dynamic> json) => RideResponse(
        message: json["message"] == null ? null : json["message"],
        ride: json["ride"] == null ? null : Ride.fromJson(json["ride"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "ride": ride == null ? null : ride.toJson(),
      };
}

class Ride {
  Ride({
    this.latitudeStart,
    this.longitudeStart,
    this.addressStart,
    this.longitudeFinish,
    this.latitudeFinish,
    this.addressFinish,
    this.startAt,
    this.endAt,
    this.date,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  final double latitudeStart;
  final double longitudeStart;
  final double longitudeFinish;
  final double latitudeFinish;
  final String addressStart;
  final String addressFinish;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime date;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Ride copyWith({
    double latitudeStart,
    double longitudeStart,
    double longitudeFinish,
    double latitudeFinish,
    String addressStart,
    String addressFinish,
    DateTime startAt,
    DateTime endAt,
    DateTime date,
    DateTime updatedAt,
    DateTime createdAt,
    int id,
  }) =>
      Ride(
        latitudeStart: latitudeStart ?? this.latitudeStart,
        longitudeStart: longitudeStart ?? this.longitudeStart,
        addressStart: addressStart ?? this.addressStart,
        longitudeFinish: longitudeFinish ?? this.longitudeFinish,
        latitudeFinish: latitudeFinish ?? this.latitudeFinish,
        addressFinish: addressFinish ?? this.addressFinish,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        date: date ?? this.date,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        latitudeStart: json["latitude_start"] == null ? null : json["latitude_start"],
        longitudeStart: json["longitude_start"] == null ? null : json["longitude_start"],
        longitudeFinish: json["longitude_finish"] == null ? null : json["longitude_finish"],
        latitudeFinish: json["latitude_finish"] == null ? null : json["latitude_finish"],
        addressStart: json["address_start"] == null ? null : json["address_start"],
        addressFinish: json["address_finish"] == null ? null : json["address_finish"],
        startAt: json["start_at"] == null ? null : DateTime.parse(json["start_at"]),
        endAt: json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
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
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}
