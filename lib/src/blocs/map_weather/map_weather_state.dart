import 'package:flutter/cupertino.dart';
import 'package:gisangdo/src/models/map_marker.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class MapWeatherState{}

class InitialMapWeather extends MapWeatherState {}

class ShowMapWeather extends MapWeatherState {
  final List<Weather> weatherList;
  final List<Marker> mapMarkerList;

  ShowMapWeather(this.weatherList, this.mapMarkerList);

  @override
  String toString() => 'Show User Location : {$weatherList} , {$mapMarkerList}';
}

class FailedMapWeather extends MapWeatherState {
  final String error;

  FailedMapWeather(this.error);

  @override
  String toString() => 'FailedUserLocation : $error';
}