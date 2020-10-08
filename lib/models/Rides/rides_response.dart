// To parse this JSON data, do
//
//     final ridesResponse = ridesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

RidesResponse ridesResponseFromJson(String str) => RidesResponse.fromJson(json.decode(str));

String ridesResponseToJson(RidesResponse data) => json.encode(data.toJson());

class RidesResponse extends Equatable {
  RidesResponse({
    this.rides,
  });

  final Rides rides;

  RidesResponse copyWith({
    Rides rides,
  }) =>
      RidesResponse(
        rides: rides ?? this.rides,
      );

  factory RidesResponse.fromJson(Map<String, dynamic> json) => RidesResponse(
        rides: json["rides"] == null ? null : Rides.fromJson(json["rides"]),
      );

  Map<String, dynamic> toJson() => {
        "rides": rides == null ? null : rides.toJson(),
      };
  @override
  List<Object> get props => [
        this.rides,
      ];
}

class Rides extends Equatable {
  Rides({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int currentPage;
  final List<Ride> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  Rides copyWith({
    int currentPage,
    List<Ride> data,
    String firstPageUrl,
    int from,
    int lastPage,
    String lastPageUrl,
    String nextPageUrl,
    String path,
    int perPage,
    String prevPageUrl,
    int to,
    int total,
  }) =>
      Rides(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Rides.fromJson(Map<String, dynamic> json) => Rides(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<Ride>.from(json["data"].map((x) => Ride.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"] == null ? null : json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl == null ? null : prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };

  @override
  List<Object> get props => [
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
      ];
}

class Ride extends Equatable {
  Ride({
    this.id,
    this.longitudeStart,
    this.latitudeStart,
    this.addressStart,
    this.longitudeFinish,
    this.latitudeFinish,
    this.addressFinish,
    this.startAt,
    this.endAt,
    this.createdAt,
    this.updatedAt,
    this.date,
  });

  final int id;
  final double longitudeStart;
  final double latitudeStart;
  final double longitudeFinish;
  final double latitudeFinish;
  final String addressFinish;
  final String addressStart;
  final String startAt;
  final String endAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime date;

  Ride copyWith({
    int id,
    double longitudeStart,
    double latitudeStart,
    double longitudeFinish,
    double latitudeFinish,
    String addressFinish,
    String addressStart,
    String startAt,
    String endAt,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime date,
  }) =>
      Ride(
        id: id ?? this.id,
        longitudeStart: longitudeStart ?? this.longitudeStart,
        latitudeStart: latitudeStart ?? this.latitudeStart,
        addressStart: addressStart ?? this.addressStart,
        longitudeFinish: longitudeFinish ?? this.longitudeFinish,
        latitudeFinish: latitudeFinish ?? this.latitudeFinish,
        addressFinish: addressFinish ?? this.addressFinish,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        date: date ?? this.date,
      );

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        id: json["id"] == null ? null : json["id"],
        longitudeStart: json["longitude_start"] == null ? null : double.parse(json["longitude_start"]),
        latitudeStart: json["latitude_start"] == null ? null : double.parse(json["latitude_start"]),
        longitudeFinish: json["longitude_finish"] == null ? null : double.parse(json["longitude_finish"]),
        latitudeFinish: json["latitude_finish"] == null ? null : double.parse(json["latitude_finish"]),
        addressFinish: json["address_finish"] == null ? null : json["address_finish"],
        addressStart: json["address_start"] == null ? null : json["address_start"],
        startAt: json["start_at"] == null ? null : DateFormat.jm().format(DateTime.parse("2020-10-06 " + json["start_at"])),
        endAt: json["end_at"] == null ? null : DateFormat.jm().format(DateTime.parse("2020-10-06 " + json["end_at"])),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "longitude_start": longitudeStart == null ? null : longitudeStart,
        "latitude_start": latitudeStart == null ? null : latitudeStart,
        "address_start": addressStart == null ? null : addressStart,
        "longitude_finish": longitudeFinish == null ? null : longitudeFinish,
        "latitude_finish": latitudeFinish == null ? null : latitudeFinish,
        "address_finish": addressFinish == null ? null : addressFinish,
        "start_at": startAt == null ? null : startAt,
        "end_at": endAt == null ? null : endAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };

  LatLng get startLocation => LatLng(this.latitudeStart, this.longitudeStart);
  LatLng get finishLocation => LatLng(this.latitudeFinish, this.longitudeFinish);

  @override
  List<Object> get props => [
        this.id,
        this.longitudeStart,
        this.latitudeStart,
        this.addressStart,
        this.longitudeFinish,
        this.latitudeFinish,
        this.addressFinish,
        this.startAt,
        this.endAt,
        this.createdAt,
        this.updatedAt,
        this.date,
      ];
}
