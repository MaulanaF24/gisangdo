import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class GetWeatherEvent {}

class FetchWeather extends GetWeatherEvent{
  final LatLng latLng;

  FetchWeather(this.latLng);

  @override
  String toString() => 'FetchWeather : {$latLng}';
}

class FetchWeatherByCity extends GetWeatherEvent {
  final String city;

  FetchWeatherByCity(this.city);

  @override
  String toString() => 'FetchWeatherByCity : $city';
}