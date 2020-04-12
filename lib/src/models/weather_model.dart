import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherModel extends Equatable{
  static const fromJsonFactory = _$WeatherModelFromJson;
  @JsonKey(name: 'coord')
  Coord coord;

  @JsonKey(name: 'weather')
  List<Weather> weather;

  @JsonKey(name: 'base')
  String base;

  @JsonKey(name: 'main')
  Main main;

  @JsonKey(name: 'visibility')
  int visibility;

  @JsonKey(name:'wind')
  Wind wind;

  @JsonKey(name: 'clouds')
  Clouds clouds;

  @JsonKey(name: 'dt')
  int dt;

  @JsonKey(name: 'sys')
  Sys sys;

  @JsonKey(name: 'timezone')
  int timezone;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'cod')
  int cod;

  WeatherModel(
      {this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class Coord extends Equatable{

  @JsonKey(name: 'lon')
  double lon;

  @JsonKey(name: 'lat')
  double lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(dynamic json) => _$CoordFromJson(json);
  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Weather extends Equatable {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'main')
  String main;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'icon')
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(dynamic json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Main extends Equatable{

  @JsonKey(name:'temp')
  double temp;

  @JsonKey(name:'feelsLike')
  double feelsLike;

  @JsonKey(name:'tempMin')
  double tempMin;

  @JsonKey(name:'tempMax')
  double tempMax;

  @JsonKey(name:'pressure')
  double pressure;

  @JsonKey(name:'humidity')
  double humidity;

  Main(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity});

  factory Main.fromJson(dynamic json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Wind extends Equatable{

  @JsonKey(name:'speed')
  double speed;



  Wind({this.speed});

  factory Wind.fromJson(dynamic json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Clouds extends Equatable{

  @JsonKey(name:'all')
  int all;

  Clouds({this.all});

  factory Clouds.fromJson(dynamic json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Sys extends Equatable{

  @JsonKey(name:'type')
  int type;

  @JsonKey(name:'id')
  int id;

  @JsonKey(name:'country')
  String country;

  @JsonKey(name:'sunrise')
  int sunrise;

  @JsonKey(name:'sunset')
  int sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(dynamic json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}