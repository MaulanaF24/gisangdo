import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/get_weather/get_weather_bloc.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/widgets/city_selection.dart';
import 'package:gisangdo/src/widgets/weather_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Forecast extends StatefulWidget {
  final LatLng latLng;

  Forecast(this.latLng);

  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
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
        BlocListener<GetWeatherBloc, GetWeatherState>(
          listener: (context, state) {
            if (state is LoadingWeatherState) {
              AwesomeDialog(
                context: context,
                animType: AnimType.LEFTSLIDE,
                headerAnimationLoop: false,
                customHeader: Image.asset(
                  'assets/jjf_spin.gif',
                ),
                dialogType: DialogType.SUCCES,
                title: 'Please Wait. . .',
                desc: '',
              ).show();
            }
            if (state is ErrorWeatherState) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.RIGHSLIDE,
                headerAnimationLoop: false,
                btnOkColor: Colors.red,
                title: 'Error',
                desc: state.error,
              ).show();
            }
            if (state is ShowWeatherState) {
              _refreshController.refreshCompleted();
              _weatherModel = state.weatherModel;
              setState(() {});
              Navigator.pop(context);
            }
          },
          child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () =>
                  BlocProvider.of<GetWeatherBloc>(context)
                      .add(FetchWeather(widget.latLng)),
              child: _weatherModel != null
                  ? WeatherWidget(weather: _weatherModel)
                  : Container()),
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
                BlocProvider.of<GetWeatherBloc>(context)
                    .add(FetchWeatherByCity(city));
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
