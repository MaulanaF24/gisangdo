import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:gisangdo/src/models/weather_model.dart';

@immutable
abstract class GetWeatherState {}

class InitialGetWeatherState extends GetWeatherState {}

class LoadingWeatherState extends GetWeatherState {}

class ShowWeatherState extends GetWeatherState {
  final Weather weatherModel;

  ShowWeatherState(this.weatherModel);

  @override
  String toString() => 'ShowWeatherState : {$weatherModel}';
}

class ErrorWeatherState extends GetWeatherState {
  final String error;

  ErrorWeatherState(this.error);
}
