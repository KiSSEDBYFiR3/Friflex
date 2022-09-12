import 'package:friflex_test_task/feature/data/model/weather_model.dart';

abstract class IWeatherRepository {
  Future<WeatherModel> fetchWeatherForecast(String cityName);
}
