import 'package:friflex_test_task/feature/data/model/weather_model.dart';

abstract class IRemoteDataSource {
  Future<WeatherModel> fetchWeatherForecast(String cityName);
}
