import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/get_weather/get_weather_event.dart';
import 'package:gisangdo/src/blocs/get_weather/get_weather_state.dart';
import 'package:gisangdo/src/repositories/weather_repository.dart';

export 'package:gisangdo/src/blocs/get_weather/get_weather_event.dart';
export 'package:gisangdo/src/blocs/get_weather/get_weather_state.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final WeatherRepository _weatherRepository;

  GetWeatherBloc(this._weatherRepository);

  @override
  GetWeatherState get initialState => LoadingWeatherState();

  @override
  Stream<GetWeatherState> mapEventToState(GetWeatherEvent event) async* {
    if (event is FetchWeather) {
      yield* _mapFetchWeatherToState(event);
    }
    if (event is FetchWeatherByCity) {
      yield* _mapFetchWeatherByCityToState(event);
    }
  }

  Stream<GetWeatherState> _mapFetchWeatherToState(FetchWeather event) async* {
    try {
      yield LoadingWeatherState();
      final weather =
      await _weatherRepository.getWeatherByUserLocation(event.latLng);
      final weathers = await _weatherRepository.getListWeather(
          weather.cityName.toUpperCase() == 'JAKARTA SPECIAL CAPITAL REGION'
              ? 'Jakarta'
              : weather.cityName);
      weather.forecast = weathers;
      print("weather : ${weather.cityName}");
      yield ShowWeatherState(weather);
    } catch (e) {
      yield ErrorWeatherState(e.toString());
    }
  }

  Stream<GetWeatherState> _mapFetchWeatherByCityToState(
      FetchWeatherByCity event) async* {
    try {
      yield LoadingWeatherState();
      final weather = await _weatherRepository.getWeatherByCity(event.city);
      final weathers = await _weatherRepository.getListWeather(event.city);
      weather.forecast = weathers;
      print("${weather.toString()}");
      yield ShowWeatherState(weather);
    } catch (e) {
      yield ErrorWeatherState(e);
    }
  }
}
