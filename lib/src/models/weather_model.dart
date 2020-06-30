import 'package:flutter/material.dart';
import 'package:gisangdo/src/models/map_marker.dart';
import 'package:gisangdo/src/utilities/icon_generator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Weather {
  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;

  String description;
  String iconCode;
  String main;
  String cityName;

  double latitude;
  double longitude;

  double windSpeed;
  double temperature;
  double maxTemperature;
  double minTemperature;

  List<Weather> forecast;

  Weather(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.description,
      this.iconCode,
      this.main,
      this.cityName,
      this.latitude,
      this.longitude,
      this.windSpeed,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.forecast});

  MapMarker toMapMarker() => MapMarker(
      id: id.toString(),
      position: LatLng(latitude, longitude),
      imageUrl: iconCode);

  Future<Marker> toMarker() async => Marker(
        markerId: MarkerId(id.toString()),
        position: LatLng(
          latitude,
          longitude,
        ),infoWindow: InfoWindow(
    title: cityName,
    snippet: '$temperature°'
  ),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(8, 8)), iconCode.toWeatherIcon()),
      );

  static Weather fromJson(Map<String, dynamic> json, {bool isList = false}) {
    final weather = json['weather'][0];
    final temp = json['main']['temp'];
    final maxTemp = json['main']['temp_max'];
    final minTemp = json['main']['temp_min'];
    final windSpeed = json['wind']['speed'];
    var latitude;
    var longitude;
    if (isList) {
      latitude = json['coord']['lat'];
      longitude = json['coord']['lon'];
    }
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: temp is int ? temp.toDouble() : temp,
      maxTemperature: maxTemp is int ? maxTemp.toDouble() : maxTemp,
      minTemperature: minTemp is int ? minTemp.toDouble() : minTemp,
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      latitude: latitude,
      longitude: longitude,
      windSpeed: windSpeed is int ? windSpeed.toDouble() : windSpeed,
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json,bool isList) {
    final weathers = (json['list'] as List)
        ?.map((e) => e == null ? null : Weather.fromJson(e, isList: isList))
        ?.toList();

    return weathers;
  }

  IconData getIconData() {
    switch (this.iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}
