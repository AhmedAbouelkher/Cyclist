import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cyclist/utils/extensions.dart';
import 'package:intl/intl.dart';

class RidePost extends Equatable {
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
  final TimeOfDay startAt;
  final TimeOfDay endAt;
  final DateTime date;

  RidePost copyWith({
    double latitudeStart,
    double longitudeStart,
    String addressStart,
    double longitudeFinish,
    double latitudeFinish,
    String addressFinish,
    TimeOfDay startAt,
    TimeOfDay endAt,
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

  Map<String, dynamic> toJson() => {
        "latitude_start": latitudeStart == null ? null : latitudeStart,
        "longitude_start": longitudeStart == null ? null : longitudeStart,
        "address_start": addressStart == null ? null : addressStart,
        "longitude_finish": longitudeFinish == null ? null : longitudeFinish,
        "latitude_finish": latitudeFinish == null ? null : latitudeFinish,
        "address_finish": addressFinish == null ? null : addressFinish,
        "start_at": startAt == null ? null : DateFormat('H:m:s').format(this.startAt.timeOfDayToDateTime()),
        "end_at": endAt == null ? null : DateFormat('H:m:s').format(this.endAt.timeOfDayToDateTime()),
        "date": date == null ? null : date.toIso8601String(),
      };

  @override
  String toString() {
    return '''
RidePost({
        latitudeStart: $latitudeStart,
        longitudeStart: $longitudeStart,
        addressStart: $addressStart,
        longitudeFinish: $longitudeFinish,
        latitudeFinish: $latitudeFinish,
        addressFinish: $addressFinish,
        startAt: ${DateFormat('H:m:s').format(this.startAt.timeOfDayToDateTime())},
        endAt: ${DateFormat('H:m:s').format(this.endAt.timeOfDayToDateTime())},
        date: $date,
      });
    ''';
  }

  @override
  List<Object> get props => [
        this.latitudeStart,
        this.longitudeStart,
        this.addressStart,
        this.longitudeFinish,
        this.latitudeFinish,
        this.addressFinish,
        this.startAt,
        this.endAt,
        this.date,
      ];
}
