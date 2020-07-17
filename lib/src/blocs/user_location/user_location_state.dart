import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class UserLocationState {}

class InitialUserLocationState extends UserLocationState {}

class ShowUserLocation extends UserLocationState {
  final LatLng userLocation;

  ShowUserLocation(this.userLocation);

  @override
  String toString() => 'Show User Location : {$userLocation}';
}

class FailedUserLocation extends UserLocationState {
  final String error;

  FailedUserLocation(this.error);

  @override
  String toString() => 'FailedUserLocation : $error';
}

class LocationIsDenied extends UserLocationState {}

class NoInternet extends UserLocationState {}

class LocationIsDisable extends UserLocationState {}