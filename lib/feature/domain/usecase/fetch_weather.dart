import 'package:friflex_test_task/feature/data/model/weather_model.dart';
import 'package:friflex_test_task/feature/domain/repository/repository.dart';

class FetchWeather {
  final IWeatherRepository _repository;

  FetchWeather(this._repository);

  Future<WeatherModel> call(String cityName) async {
    return await _repository.fetchWeatherForecast(cityName);
  }
}
