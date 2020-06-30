import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class MapWeatherEvent{}

class FetchMapWeather extends MapWeatherEvent{
  final LatLng latLng;

  FetchMapWeather(this.latLng);
}