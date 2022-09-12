import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_test_task/core/constants/colors.dart';
import 'package:friflex_test_task/core/di/di.dart';
import 'package:friflex_test_task/feature/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:friflex_test_task/feature/presentation/screens/current_weather_screen.dart';
import 'package:friflex_test_task/feature/presentation/screens/home_page.dart';
import 'package:friflex_test_task/feature/presentation/screens/weather_forecast.dart';

void main() {
  final container = buildContainer();
  final app = container.buildApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  final WeatherCubit weatherCubit;
  const MyApp({Key? key, required this.weatherCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white))),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: AppColors.primaryColor, secondary: Colors.white)),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider.value(
            value: weatherCubit,
            child: HomePage(
              weatherCubit: weatherCubit,
            )),
        '/second': (context) => BlocProvider.value(
            value: weatherCubit,
            child: CurrentWeatherScreen(
              weatherCubit: weatherCubit,
            )),
        '/third': (context) => BlocProvider.value(
            value: weatherCubit,
            child: WeatherForecast(weatherCubit: weatherCubit))
      },
    );
  }
}
