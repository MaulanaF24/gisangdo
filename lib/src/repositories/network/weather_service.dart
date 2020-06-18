import 'package:chopper/chopper.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/repositories/response/weather_list_response.dart';

@ChopperApi()
abstract class WeatherService extends ChopperService {

  @Get(path: 'weather?',headers: {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'})
  Future<Response<Weather>> getWeatherUserLocation(
      {@Query('lat') double lat,
      @Query('lon') double lon,
      @Query('units') String unitsType});

  @Get(path: 'weather?',headers: {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'})
  Future<Response<Weather>> getWeatherByCityName(
      {@Query('city') String city, @Query('units') String unitsType});

  @Get(path: 'find?',headers: {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'})
  Future<Response<WeatherListResponse>> getWeatherList(
      {@Query('lat') double lat,
      @Query('lon') double lon,
      @Query('cnt') int cnt,
      @Query('units') String unitsType});
}
