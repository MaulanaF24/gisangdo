import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/get_weather/get_weather_bloc.dart';
import 'package:gisangdo/src/blocs/map_weather/map_weather_bloc.dart';
import 'package:gisangdo/src/blocs/user_location/user_location_bloc.dart';
import 'package:gisangdo/src/page/dashboard.dart';
import 'package:gisangdo/src/repositories/network/weather_api_service.dart';
import 'package:gisangdo/src/repositories/weather_repository.dart';
import 'package:http/http.dart';

void main() {
  final WeatherRepository weatherRepository =
      WeatherRepository(WeatherApiService(httpClient: Client()));

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(GisangdoApp(weatherRepository));
}

class GisangdoApp extends StatelessWidget {
  final WeatherRepository _weatherRepository;

  GisangdoApp(this._weatherRepository);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gisangdo',
        theme: ThemeData(
            primaryColor: Colors.lightBlue[800],
            accentColor: Colors.cyan[600],
            fontFamily: 'Montserrat',
            brightness: Brightness.light,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary)),
        darkTheme: ThemeData(
            primaryColor: Colors.lightBlue[800],
            accentColor: Colors.cyan[600],
            fontFamily: 'Montserrat',
            brightness: Brightness.dark,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary)),
        home: MultiBlocProvider(providers: [
          BlocProvider<UserLocationBloc>(
              create: (context) => UserLocationBloc()),
          BlocProvider<GetWeatherBloc>(
              create: (context) => GetWeatherBloc(
                  _weatherRepository, RepositoryProvider.of(context))),
          BlocProvider<MapWeatherBloc>(
              create: (context) => MapWeatherBloc(_weatherRepository)),
        ], child: Dashboard()));
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition.toString());
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error.toString());
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event.toString());
  }
}
