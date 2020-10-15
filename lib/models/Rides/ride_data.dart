// To parse this JSON data, do
//
//     final spacificRide = spacificRideFromJson(jsonString);

import 'dart:convert';

SpacificRide spacificRideFromJson(String str) => SpacificRide.fromJson(json.decode(str));

String spacificRideToJson(SpacificRide data) => json.encode(data.toJson());

class SpacificRide {
  SpacificRide({
    this.ride,
    this.comments,
  });

  final Ride ride;
  final Comments comments;

  SpacificRide copyWith({
    Ride ride,
    Comments comments,
  }) =>
      SpacificRide(
        ride: ride ?? this.ride,
        comments: comments ?? this.comments,
      );

  factory SpacificRide.fromJson(Map<String, dynamic> json) => SpacificRide(
        ride: json["ride"] == null ? null : Ride.fromJson(json["ride"]),
        comments: json["comments"] == null ? null : Comments.fromJson(json["comments"]),
      );

  Map<String, dynamic> toJson() => {
        "ride": ride == null ? null : ride.toJson(),
        "comments": comments == null ? null : comments.toJson(),
      };
}

class Comments {
  Comments({
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
  final List<Comment> data;
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

  Comments copyWith({
    int currentPage,
    List<Comment> data,
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
      Comments(
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

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
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
}

class Comment {
  Comment({
    this.id,
    this.rideId,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String rideId;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment copyWith({
    int id,
    String rideId,
    String comment,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Comment(
        id: id ?? this.id,
        rideId: rideId ?? this.rideId,
        comment: comment ?? this.comment,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] == null ? null : json["id"],
        rideId: json["ride_id"] == null ? null : json["ride_id"],
        comment: json["comment"] == null ? null : json["comment"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "ride_id": rideId == null ? null : rideId,
        "comment": comment == null ? null : comment,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Ride {
  Ride({
    this.id,
    this.longitudeStart,
    this.latitudeStart,
    this.addressStart,
    this.longitudeFinish,
    this.latitudeFinish,
    this.addressFinish,
    this.date,
    this.startAt,
    this.endAt,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String longitudeStart;
  final String latitudeStart;
  final String addressStart;
  final String longitudeFinish;
  final String latitudeFinish;
  final String addressFinish;
  final DateTime date;
  final String startAt;
  final String endAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Ride copyWith({
    int id,
    String longitudeStart,
    String latitudeStart,
    String addressStart,
    String longitudeFinish,
    String latitudeFinish,
    String addressFinish,
    DateTime date,
    String startAt,
    String endAt,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Ride(
        id: id ?? this.id,
        longitudeStart: longitudeStart ?? this.longitudeStart,
        latitudeStart: latitudeStart ?? this.latitudeStart,
        addressStart: addressStart ?? this.addressStart,
        longitudeFinish: longitudeFinish ?? this.longitudeFinish,
        latitudeFinish: latitudeFinish ?? this.latitudeFinish,
        addressFinish: addressFinish ?? this.addressFinish,
        date: date ?? this.date,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        id: json["id"] == null ? null : json["id"],
        longitudeStart: json["longitude_start"] == null ? null : json["longitude_start"],
        latitudeStart: json["latitude_start"] == null ? null : json["latitude_start"],
        addressStart: json["address_start"] == null ? null : json["address_start"],
        longitudeFinish: json["longitude_finish"] == null ? null : json["longitude_finish"],
        latitudeFinish: json["latitude_finish"] == null ? null : json["latitude_finish"],
        addressFinish: json["address_finish"] == null ? null : json["address_finish"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startAt: json["start_at"] == null ? null : json["start_at"],
        endAt: json["end_at"] == null ? null : json["end_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "longitude_start": longitudeStart == null ? null : longitudeStart,
        "latitude_start": latitudeStart == null ? null : latitudeStart,
        "address_start": addressStart == null ? null : addressStart,
        "longitude_finish": longitudeFinish == null ? null : longitudeFinish,
        "latitude_finish": latitudeFinish == null ? null : latitudeFinish,
        "address_finish": addressFinish == null ? null : addressFinish,
        "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_at": startAt == null ? null : startAt,
        "end_at": endAt == null ? null : endAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
