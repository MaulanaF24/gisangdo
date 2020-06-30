import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/map_weather/map_weather_bloc.dart';
import 'package:gisangdo/src/utilities/cluster_google_map.dart';
import 'package:gisangdo/src/widgets/weather_item_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final LatLng latLng;

  Maps(this.latLng);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> with AutomaticKeepAliveClientMixin {
  ClusterGoogleMapController _clusterGoogleMapController =
      ClusterGoogleMapController();
  bool isCollapsed = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MapWeatherBloc>(context)
        .add(FetchMapWeather(widget.latLng));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MapWeatherBloc, MapWeatherState>(
      builder: (context, state) {
        if (state is ShowMapWeather) {
          final weatherList = state.weatherList;
          return Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: ClusterGoogleMap(
                    center: widget.latLng,
                    controller: _clusterGoogleMapController,
                    markerList: state.mapMarkerList,
                  )),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Text('   City List'),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Icon(
                          isCollapsed
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isCollapsed) {
                              isCollapsed = false;
                            } else {
                              isCollapsed = true;
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              if (isCollapsed)
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: weatherList.length,
                    itemBuilder: (context, index) {
                      final weather = weatherList[index];
                      return WeatherItemWidget(weather: weather);
                    },
                  ),
                )
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
