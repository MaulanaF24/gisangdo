import 'package:flutter/material.dart';

extension WeatherIconGenerator on String {
  String toWeatherIcon() {
    switch (this) {
      case "02d":
      case "02n":
        return "assets/berawan.png";
        break;

      case "03d":
      case "03n":
      case "04d":
      case "04n":
        return "assets/mendung.png";
        break;

      case "09d":
      case "09n":
      case "10d":
      case "10n":
        return "assets/hujan.png";
        break;

      case "11d":
      case "11n":
        return "assets/badai.png";
        break;

      case "13d":
      case "13n":
        return "assets/bersalju.png";
        break;

      case "50d":
      case "50n":
        return "assets/berangin.png";
        break;

      case "01d":
      case "01n":
      default:
        return "assets/cerah.png";
        break;
    }
  }
}

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
    codePoint,
    fontFamily: 'WeatherIcons',
  );
}

class WeatherIcons {
  static const IconData clear_day = const _IconData(0xf00d);
  static const IconData clear_night = const _IconData(0xf02e);

  static const IconData few_clouds_day = const _IconData(0xf002);
  static const IconData few_clouds_night = const _IconData(0xf081);

  static const IconData clouds_day = const _IconData(0xf07d);
  static const IconData clouds_night = const _IconData(0xf080);

  static const IconData shower_rain_day = const _IconData(0xf009);
  static const IconData shower_rain_night = const _IconData(0xf029);

  static const IconData rain_day = const _IconData(0xf008);
  static const IconData rain_night = const _IconData(0xf028);

  static const IconData thunder_storm_day = const _IconData(0xf010);
  static const IconData thunder_storm_night = const _IconData(0xf03b);

  static const IconData snow_day = const _IconData(0xf00a);
  static const IconData snow_night = const _IconData(0xf02a);

  static const IconData mist_day = const _IconData(0xf003);
  static const IconData mist_night = const _IconData(0xf04a);


}

