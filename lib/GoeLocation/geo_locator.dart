import 'package:cyclist/GoeLocation/models.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' hide LocationAccuracy;

class LocationServices {
  factory LocationServices() => instance;
  LocationServices._();
  static final LocationServices instance = LocationServices._();

  static Future<LocationFuture> getCoords() async {
    final position = await getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    return Future.value(LocationFuture(
      position.latitude,
      position.longitude,
      position.accuracy,
      position.speed,
      position.heading,
      position.timestamp,
    ));
  }

  static Stream<LocationStream> getCoordsAsStream() {
    return getPositionStream(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    ).map<LocationStream>((event) => LocationStream(
          event.latitude,
          event.longitude,
          event.accuracy,
          event.speed,
          event.heading,
          event.timestamp,
        ));
  }

  static double calculateDistance({@required CLocation oldLocation, @required CLocation newLocation}) {
    return distanceBetween(oldLocation.lat, oldLocation.lang, newLocation.lat, newLocation.lang);
  }
}

extension ToCLocation on LocationData {
  CLocation toLocation() {
    return LocationDataFuture(this.latitude, this.longitude, this.accuracy, this.speed, this.heading, null);
  }
}

extension PositionToCLocation on Position {
  CLocation toLocation() {
    return LocationDataFuture(this.latitude, this.longitude, this.accuracy, this.speed, this.heading, null);
  }
}

extension LatLngToCLocation on LatLng {
  CLocation toLocation() {
    return LocationDataFuture(this.latitude, this.longitude, null, null, null, null);
  }
}
