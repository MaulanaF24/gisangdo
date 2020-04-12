import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/get_weather/get_weather_event.dart';
import 'package:gisangdo/src/blocs/get_weather/get_weather_state.dart';
import 'package:gisangdo/src/blocs/user_location/user_location_bloc.dart';
import 'package:gisangdo/src/repositories/weather_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

export 'package:gisangdo/src/blocs/get_weather/get_weather_event.dart';
export 'package:gisangdo/src/blocs/get_weather/get_weather_state.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final WeatherRepository _weatherRepository;
  final UserLocationBloc _userLocationBloc;
  StreamSubscription _locationSubscription;
  LatLng _userLocation;

  GetWeatherBloc(this._weatherRepository,this._userLocationBloc){
   _locationSubscription = _userLocationBloc.listen((state) {
     if(state is ShowUserLocation){
       _userLocation = state.userLocation;
       add(FetchWeather(state.userLocation));
     }
   });
  }

  @override
  GetWeatherState get initialState => InitialGetWeatherState();

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
      final weather =
          await _weatherRepository.getWeatherByUserLocation(event.latLng);
      print("weather : ${weather.weather}");
      yield ShowWeatherState(weather);
    } catch (e) {
      yield ErrorWeatherState(e.toString());
    }
  }

  Stream<GetWeatherState> _mapFetchWeatherByCityToState(
      FetchWeatherByCity event) async* {
    try {
      final weather = await _weatherRepository.getWeatherByCity(event.city);
      print("${weather.weather}");
      yield ShowWeatherState(weather);
    } catch (e) {
      yield ErrorWeatherState(e);
    }
  }
}
