import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_test_task/feature/data/model/weather_model.dart';
import 'package:friflex_test_task/feature/domain/usecase/fetch_weather.dart';
import 'package:friflex_test_task/feature/presentation/bloc/weather_cubit/weather_states.dart';

// Cubit создаю в единственном экземпляре для второго и третьего экранов.
// Таким образом, когда мы делаем запрос, кубит сохраняет данные и мы можем их переиспользовать на обоих экранах, не делая дополнительных запросов
class WeatherCubit extends Cubit<WeatherStates> {
  final FetchWeather _fetchWeather;

  WeatherCubit(this._fetchWeather) : super(const WeatherInitialState());

  Future<void> fetchForecast(String cityName) async {
    emit(const WeatherLoadingState());
    try {
      final WeatherModel weather = await _fetchWeather.call(cityName);
      emit(WeatherLoadedState(weather, cityName));
    } catch (error) {
      emit(WeatherErrorState(error.toString()));
    }
  }
}
