import 'package:gisangdo/src/models/weather_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class WeatherListResponse {
  static const fromJsonFactory = _$WeatherListResponseFromJson;

  @JsonKey(name: 'list')
  final List<WeatherModel> weatherList;

  WeatherListResponse(this.weatherList);

  factory WeatherListResponse.fromJson(Map<String, dynamic> json) => _$WeatherListResponseFromJson(json);
}

WeatherListResponse _$WeatherListResponseFromJson(Map<String, dynamic> json) {
  return WeatherListResponse((json['list'] as List)
      ?.map((e) => e == null ? null : WeatherModel.fromJson(e))
      ?.toList());
}
