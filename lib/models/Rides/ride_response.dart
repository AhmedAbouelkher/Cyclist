// To parse this JSON data, do
//
//     final rideResponse = rideResponseFromJson(jsonString);

import 'dart:convert';
import 'package:equatable/equatable.dart';

RideResponse rideResponseFromJson(String str) => RideResponse.fromJson(json.decode(str));

String rideResponseToJson(RideResponse data) => json.encode(data.toJson());

class RideResponse extends Equatable {
  RideResponse({
    this.message,
  });

  final String message;

  factory RideResponse.fromJson(Map<String, dynamic> json) => RideResponse(
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
      };

  @override
  List<Object> get props => [
        this.message,
      ];
}
