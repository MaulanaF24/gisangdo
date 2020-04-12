import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/get_weather/get_weather_bloc.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Forecast extends StatefulWidget {
  final LatLng latLng;

  Forecast(this.latLng);

  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _searchController = TextEditingController();
  WeatherModel _weatherModel;

  @override
  void initState() {
    super.initState();
    //BlocProvider.of<GetWeatherBloc>(context).add(FetchWeather(widget.latLng));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Search",
                  hintText: "Type your city's name",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      BlocProvider.of<GetWeatherBloc>(context)
                          .add(FetchWeatherByCity(_searchController.text));
                      print(_searchController.text);
                    },
                  )),
            ),
          ),
          SizedBox(height: 5),
          BlocBuilder<GetWeatherBloc, GetWeatherState>(
            builder: (context, state) {
              print(state.toString());
              if (state is ShowWeatherState) {
                _weatherModel = state.weatherModel;
                return Expanded(
                  flex: 9,
                  child: Column(
                    children: <Widget>[Text(_weatherModel.name)],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
