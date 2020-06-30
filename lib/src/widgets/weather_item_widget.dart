import 'package:flutter/material.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/utilities/icon_generator.dart';
import 'package:intl/intl.dart';

class WeatherItemWidget extends StatelessWidget {
  final Weather weather;

  WeatherItemWidget({this.weather});

  String get time => DateFormat('E, ha')
      .format(DateTime.fromMillisecondsSinceEpoch(weather.time * 1000));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 10.0, top: 6.0, bottom: 6.0),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image(
                      height: 46,
                      width: 46,
                      image: AssetImage(weather.iconCode.toWeatherIcon()),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            weather.description ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 10.0),
                          ),
                          Text(
                            weather.cityName ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14.0),
                          ),
                          Text(time,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 10.0)),
                          Text(
                            'Humidity : ${weather.humidity}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 10.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '● ${weather.temperature}°'.toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
