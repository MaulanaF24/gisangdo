import 'package:geolocator/geolocator.dart';
import 'package:gisangdo/src/blocs/user_location/user_location_bloc.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/repositories/network/weather_api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class WeatherRepository {
 final WeatherApiService _weatherApiService;

 WeatherRepository(this._weatherApiService);

  Future<WeatherModel> getWeatherByUserLocation(LatLng latLng) async {
    final response = await _weatherApiService.getWeatherByUserLocation(latLng);
    return response;
  }

 Future<WeatherModel> getWeatherByCity(String city) async {
   final response = await _weatherApiService.getWeatherByCity(city);
   return response;
 }

 Future<List<WeatherModel>> getListWeather(LatLng latLng) async {
    final response = await _weatherApiService.getListWeather(latLng);
    return response.weatherList;
 }
}
