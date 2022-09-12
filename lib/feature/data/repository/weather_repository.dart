import 'package:friflex_test_task/feature/data/data_source/remote_data_source/i_remote_data_source.dart';
import 'package:friflex_test_task/feature/data/model/weather_model.dart';
import 'package:friflex_test_task/feature/domain/repository/repository.dart';

class WeatherRepository implements IWeatherRepository {
  final IRemoteDataSource _remoteDataSource;
  WeatherRepository(this._remoteDataSource);

  @override
  Future<WeatherModel> fetchWeatherForecast(String cityName) async {
    return await _remoteDataSource.fetchWeatherForecast(cityName);
  }
}
