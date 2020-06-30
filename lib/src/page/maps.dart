import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/map_weather/map_weather_bloc.dart';
import 'package:gisangdo/src/utilities/cluster_google_map.dart';
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
          return Column(
            children: <Widget>[
              Expanded(
                  child: ClusterGoogleMap(
                center: widget.latLng,
                controller: _clusterGoogleMapController,
                markerList: state.mapMarkerList,
              )),
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
