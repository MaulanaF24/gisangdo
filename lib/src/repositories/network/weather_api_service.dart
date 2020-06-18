import 'dart:convert';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/repositories/response/weather_list_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class WeatherApiService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5";
  static const apiKey = 'ccc5f058edb6c2e9317bd58911650752';
  final Client httpClient;

  WeatherApiService({this.httpClient}) : assert(httpClient != null);

  Future<Weather> getWeatherByUserLocation(LatLng latLng) async {
    final url =
        "$baseUrl/weather?lat=${latLng.latitude}&lon=${latLng.longitude}&units=metric&appid=$apiKey";
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    return Weather.fromJson(json);
  }

  Future<Weather> getWeatherByCity(String city) async {
    final url =
        "$baseUrl/weather?q=$city&units=metric&appid=$apiKey";
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    return Weather.fromJson(json);
  }

  Future<List<Weather>> getListWeather(LatLng latLng) async {
    final url =
        "$baseUrl/weather?lat=${latLng.latitude}&lon=${latLng.longitude}&cnt=10&units=metric&appid=$apiKey";
    final response = await httpClient.get(url);
    final json = jsonDecode(response.body);
    final weathers = Weather.fromForecastJson(json);
    return weathers;
  }

  Future<List<Weather>> getForecast(String cityName) async {
    final url = '$baseUrl/forecast?q=$cityName&appid=$apiKey';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
