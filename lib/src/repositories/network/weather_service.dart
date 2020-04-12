import 'package:chopper/chopper.dart';
import 'package:gisangdo/src/models/weather_model.dart';
import 'package:gisangdo/src/repositories/response/weather_list_response.dart';

part 'weather_service.chopper.dart';

@ChopperApi()
abstract class WeatherService extends ChopperService {
  static WeatherService create() {
    final client = ChopperClient(
        baseUrl: "api.openweathermap.org/data/2.5/",
        converter: JsonConverter(),
        services: [
          _$WeatherService(),
        ]);
    return _$WeatherService(client);
  }

  @Get(path: 'weather?',headers: {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'})
  Future<Response<WeatherModel>> getWeatherUserLocation(
      {@Query('lat') double lat,
      @Query('lon') double lon,
      @Query('units') String unitsType});

  @Get(path: 'weather?',headers: {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'})
  Future<Response<WeatherModel>> getWeatherByCityName(
      {@Query('city') String city, @Query('units') String unitsType});

  @Get(path: 'find?',headers: {'x-api-key': 'ccc5f058edb6c2e9317bd58911650752'})
  Future<Response<WeatherListResponse>> getWeatherList(
      {@Query('lat') double lat,
      @Query('lon') double lon,
      @Query('cnt') int cnt,
      @Query('units') String unitsType});
}
