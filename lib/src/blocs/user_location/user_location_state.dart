import 'package:flutter/cupertino.dart';
import 'package:gisangdo/src/blocs/user_location/user_location_bloc.dart';
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