import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/get_weather/get_weather_bloc.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/widgets/city_selection.dart';
import 'package:gisangdo/src/widgets/weather_widget.dart';

class Forecast extends StatefulWidget {
  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _searchController = TextEditingController();
  Weather _weatherModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        BlocBuilder<GetWeatherBloc, GetWeatherState>(
          builder: (context, state) {
            print(state.toString());
            if (state is ShowWeatherState) {
              _weatherModel = state.weatherModel;
              return WeatherWidget(weather: _weatherModel);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<GetWeatherBloc>(context).add(FetchWeatherByCity(city));
              }
            },
            child: Icon(Icons.search),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
