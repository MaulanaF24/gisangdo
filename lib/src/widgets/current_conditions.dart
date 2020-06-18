import 'package:flutter/material.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/widgets/value_tile.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  final Weather weather;
  const CurrentConditions({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          size: 70,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${this.weather.temperature}°',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("max",
              '${this.weather.maxTemperature}°'),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
            )),
          ),
          ValueTile("min",
              '${this.weather.minTemperature}°'),
        ]),
      ],
    );
  }
}
