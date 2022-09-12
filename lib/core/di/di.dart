import 'package:flutter/cupertino.dart';
import 'package:friflex_test_task/feature/data/data_source/remote_data_source/i_remote_data_source.dart';
import 'package:friflex_test_task/feature/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:friflex_test_task/feature/data/repository/weather_repository.dart';
import 'package:friflex_test_task/feature/domain/repository/repository.dart';
import 'package:friflex_test_task/feature/domain/usecase/fetch_weather.dart';
import 'package:friflex_test_task/feature/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:friflex_test_task/main.dart';

// Интерфейс для контейнера
abstract class IDiContainer {
  Widget buildApp();
}

// Функция, которая собирает контейнер и передает его экземпляр в main
IDiContainer buildContainer() => DiContainer();

// Здесь собираются все зависимости
class DiContainer implements IDiContainer {
  IRemoteDataSource _buildRemoteDataSource() => RemoteDataSource();
  IWeatherRepository _buildWeatherRepository() =>
      WeatherRepository(_buildRemoteDataSource());
  FetchWeather _buildFecthWeather() => FetchWeather(_buildWeatherRepository());

  // Единственный экземпляр кубита, который хранит состояние и данные, которые можем переиспользовать в третьем экране
  WeatherCubit _buildWeatherCubit() => WeatherCubit(_buildFecthWeather());
  // Метод, собирающий MyApp, который уже содержит в себе все необходимые зависимости
  @override
  Widget buildApp() => MyApp(weatherCubit: _buildWeatherCubit());
}
