import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/repositories/response/weather_list_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class WeatherApiService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5";
  static const apiKey = 'ccc5f058edb6c2e9317bd58911650752';
  final Client httpClient;

  WeatherApiService({@required this.httpClient}) : assert(httpClient != null);

  Future<WeatherModel> getWeatherByUserLocation(LatLng latLng) async {
    final url =
        "$baseUrl/weather?lat=${latLng.latitude}&lon=${latLng.longitude}&units=metric&appid=$apiKey";
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    return WeatherModel.fromJson(json);
  }

  Future<WeatherModel> getWeatherByCity(String city) async {
    final url =
        "$baseUrl/weather?q=$city&units=metric&appid=$apiKey";
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    return WeatherModel.fromJson(json);
  }

  Future<WeatherListResponse> getListWeather(LatLng latLng) async {
    final url =
        "$baseUrl/weather?lat=${latLng.latitude}&lon=${latLng.longitude}&cnt=10&units=metric&appid=$apiKey";
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    return WeatherListResponse.fromJson(json);
  }
}
