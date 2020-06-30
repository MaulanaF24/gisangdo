import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/map_weather/map_weather_event.dart';
import 'package:gisangdo/src/blocs/map_weather/map_weather_state.dart';
import 'package:gisangdo/src/repositories/weather_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

export 'package:gisangdo/src/blocs/map_weather/map_weather_event.dart';
export 'package:gisangdo/src/blocs/map_weather/map_weather_state.dart';

class MapWeatherBloc extends Bloc<MapWeatherEvent, MapWeatherState> {
  final WeatherRepository _weatherRepository;

  MapWeatherBloc(this._weatherRepository);

  @override
  MapWeatherState get initialState => InitialMapWeather();

  @override
  Stream<MapWeatherState> mapEventToState(MapWeatherEvent event) async* {
    if (event is FetchMapWeather) {
      yield* _fetchMapEventToState(event);
    }
  }

  Stream<MapWeatherState> _fetchMapEventToState(FetchMapWeather event) async* {
    try {
      final weathers = await _weatherRepository.getMapWeather(event.latLng);
      final mapMarketList = <Marker>[];
      await Future.forEach(weathers, (each) async {
        final marker = await each.toMarker();
        mapMarketList.add(marker);
      });
      yield ShowMapWeather(weathers, mapMarketList);
    } catch (e) {
      yield FailedMapWeather(e.toString());
    }
  }
}
