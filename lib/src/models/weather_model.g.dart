// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) {
  return WeatherModel(
    coord: json['coord'] == null ? null : Coord.fromJson(json['coord']),
    weather: (json['weather'] as List)
        ?.map((e) => e == null ? null : Weather.fromJson(e))
        ?.toList(),
    base: json['base'] as String,
    main: json['main'] == null ? null : Main.fromJson(json['main']),
    visibility: json['visibility'] as int,
    wind: json['wind'] == null ? null : Wind.fromJson(json['wind']),
    clouds: json['clouds'] == null ? null : Clouds.fromJson(json['clouds']),
    dt: json['dt'] as int,
    sys: json['sys'] == null ? null : Sys.fromJson(json['sys']),
    timezone: json['timezone'] as int,
    id: json['id'] as int,
    name: json['name'] as String,
    cod: json['cod'] as int,
  );
}

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'coord': instance.coord?.toJson(),
      'weather': instance.weather?.map((e) => e?.toJson())?.toList(),
      'base': instance.base,
      'main': instance.main?.toJson(),
      'visibility': instance.visibility,
      'wind': instance.wind?.toJson(),
      'clouds': instance.clouds?.toJson(),
      'dt': instance.dt,
      'sys': instance.sys?.toJson(),
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
      'cod': instance.cod,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) {
  return Coord(
    lon: (json['lon'] as num)?.toDouble(),
    lat: (json['lat'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    id: json['id'] as int,
    main: json['main'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
    temp: (json['temp'] as num)?.toDouble(),
    feelsLike: (json['feelsLike'] as num)?.toDouble(),
    tempMin: (json['tempMin'] as num)?.toDouble(),
    tempMax: (json['tempMax'] as num)?.toDouble(),
    pressure: (json['pressure'] as num)?.toDouble(),
    humidity: (json['humidity'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
    speed: (json['speed'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) {
  return Clouds(
    all: json['all'] as int,
  );
}

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Sys _$SysFromJson(Map<String, dynamic> json) {
  return Sys(
    type: json['type'] as int,
    id: json['id'] as int,
    country: json['country'] as String,
    sunrise: json['sunrise'] as int,
    sunset: json['sunset'] as int,
  );
}

Map<String, dynamic> _$SysToJson(Sys instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
