// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$WeatherService extends WeatherService {
  _$WeatherService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = WeatherService;

  @override
  Future<Response<WeatherModel>> getWeatherUserLocation(
      {double lat, double lon, String unitsType}) {
    final $url = 'weather';
    final $params = <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'units': unitsType
    };
    final $headers = {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<WeatherModel, WeatherModel>($request);
  }

  @override
  Future<Response<WeatherModel>> getWeatherByCityName(
      {String city, String unitsType}) {
    final $url = 'weather';
    final $params = <String, dynamic>{'city': city, 'units': unitsType};
    final $headers = {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<WeatherModel, WeatherModel>($request);
  }

  @override
  Future<Response<WeatherListResponse>> getWeatherList(
      {double lat, double lon, int cnt, String unitsType}) {
    final $url = 'weather';
    final $params = <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'cnt': cnt,
      'units': unitsType
    };
    final $headers = {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<WeatherListResponse, WeatherListResponse>($request);
  }
}
