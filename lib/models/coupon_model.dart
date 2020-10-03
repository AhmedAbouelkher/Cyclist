// To parse this JSON data, do
//
//     final couponResponse = couponResponseFromJson(jsonString);

import 'dart:convert';

CouponResponse couponResponseFromJson(String str) => CouponResponse.fromJson(json.decode(str));

String couponResponseToJson(CouponResponse data) => json.encode(data.toJson());

class CouponResponse {
  CouponResponse({
    this.coupon,
  });

  final Coupon coupon;

  CouponResponse copyWith({
    Coupon coupon,
  }) =>
      CouponResponse(
        coupon: coupon ?? this.coupon,
      );

  factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
      );

  Map<String, dynamic> toJson() => {
        "coupon": coupon == null ? null : coupon.toJson(),
      };
}

class Coupon {
  Coupon({
    this.id,
    this.coupon,
    this.value,
    this.timeOut,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String coupon;
  final String value;
  final DateTime timeOut;
  final DateTime createdAt;
  final DateTime updatedAt;

  Coupon copyWith({
    int id,
    String coupon,
    String value,
    DateTime timeOut,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Coupon(
        id: id ?? this.id,
        coupon: coupon ?? this.coupon,
        value: value ?? this.value,
        timeOut: timeOut ?? this.timeOut,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"] == null ? null : json["id"],
        coupon: json["coupon"] == null ? null : json["coupon"],
        value: json["value"] == null ? null : json["value"],
        timeOut: json["time_out"] == null ? null : DateTime.parse(json["time_out"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "coupon": coupon == null ? null : coupon,
        "value": value == null ? null : value,
        "time_out": timeOut == null
            ? null
            : "${timeOut.year.toString().padLeft(4, '0')}-${timeOut.month.toString().padLeft(2, '0')}-${timeOut.day.toString().padLeft(2, '0')}",
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
