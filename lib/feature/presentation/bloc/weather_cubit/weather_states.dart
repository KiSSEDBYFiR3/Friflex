import 'package:equatable/equatable.dart';
import 'package:friflex_test_task/feature/data/model/weather_model.dart';

class WeatherStates extends Equatable {
  const WeatherStates();

  @override
  List<Object?> get props => [];
}

class WeatherInitialState extends WeatherStates {
  const WeatherInitialState();
  @override
  List<Object?> get props => [];
}

class WeatherLoadingState extends WeatherStates {
  const WeatherLoadingState();

  @override
  List<Object?> get props => [];
}

class WeatherLoadedState extends WeatherStates {
  final WeatherModel weatherModel;
  final String cityName;

  const WeatherLoadedState(this.weatherModel, this.cityName);

  @override
  List<Object?> get props => [weatherModel, cityName];
}

class WeatherErrorState extends WeatherStates {
  final String message;

  const WeatherErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
