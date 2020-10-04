import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class CLocation extends Equatable {
  final double lat;
  final double lang;
  final double accuracy;
  final double speed;
  final double heading;
  final dynamic time;

  CLocation(this.lat, this.lang, this.accuracy, this.speed, this.heading, this.time);

  @override
  List<Object> get props => [this.lat, this.lang, this.accuracy, this.heading, this.speed, this.time];

  @override
  String toString() => "Location(${this.lat}, ${this.lang})";

  LatLng toLatLng() => LatLng(this.lat, this.lang);

  Position toPosition() => Position(latitude: this.lat, longitude: this.lang);
}

class LocationFuture extends CLocation {
  LocationFuture(
    double lat,
    double lang,
    double accuracy,
    double speed,
    double heading,
    dynamic time,
  ) : super(lat, lang, accuracy, speed, heading, time);
}

class LocationStream extends CLocation {
  LocationStream(
    double lat,
    double lang,
    double accuracy,
    double speed,
    double heading,
    dynamic time,
  ) : super(lat, lang, accuracy, speed, heading, time);
}

class LocationDataFuture extends CLocation {
  LocationDataFuture(
    double lat,
    double lang,
    double accuracy,
    double speed,
    double heading,
    dynamic time,
  ) : super(lat, lang, accuracy, speed, heading, time);
}
