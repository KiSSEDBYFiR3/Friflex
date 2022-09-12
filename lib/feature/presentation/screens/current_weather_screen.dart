import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_test_task/core/constants/assets_list.dart';
import 'package:friflex_test_task/feature/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:friflex_test_task/feature/presentation/bloc/weather_cubit/weather_states.dart';
import 'package:friflex_test_task/feature/presentation/widgets/animated_background.dart';
import 'package:friflex_test_task/feature/presentation/widgets/row_tile.dart';

class CurrentWeatherScreen extends StatelessWidget {
  final WeatherCubit weatherCubit;
  final int _counter = 0;

  const CurrentWeatherScreen({Key? key, required this.weatherCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 80,
        title: const Text(
          "Погода",
          style: TextStyle(
            fontSize: 32,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            size: 32,
          ),
          onPressed: () => Navigator.of(context).pushNamed('/'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // Проверяю соответствует ли текущее состояние WeatherLoadedState
                // Если да, то разрешаю пуш на третью страницу
                if (weatherCubit.state is WeatherLoadedState) {
                  Navigator.of(context).pushNamed('/third');
                }
              },
              icon: const Icon(
                Icons.list_outlined,
                size: 32,
              ))
        ],
      ),
      body: Stack(children: [
        animatedBackground(context, _counter),
        BlocConsumer<WeatherCubit, WeatherStates>(
            // передаю экземпляр конкретного кубита, чтобы избежать ошибок
            bloc: weatherCubit,
            builder: (context, state) {
              if (state is WeatherLoadingState) {
                return const Center(
                  // индикатор загрузки
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherErrorState) {
                // в случае ошибки отображаю текст в центре
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      'Ошибка получения данных',
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Montserrat",
                          color: Colors.black),
                    ),
                  ),
                );
              } else if (state is WeatherLoadedState) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.cyan.shade50.withOpacity(0.3)),
                    height: MediaQuery.of(context).size.height * 0.58,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(children: [
                      Center(
                        child: Text(
                          state.cityName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              fontSize: 50),
                        ),
                      ),
                      rowTile(
                          context,
                          AssetsPath.assetsList[0],
                          state.weatherModel.list?[0].main?.tempMin
                                  ?.toStringAsFixed(1) ??
                              ''), // не ставлю бэнг оператор, так как можно словить красный экран
                      rowTile(
                          context,
                          AssetsPath.assetsList[1],
                          state.weatherModel.list?[0].wind?.speed
                                  ?.toStringAsFixed(1) ??
                              ''),
                      rowTile(
                          context,
                          AssetsPath.assetsList[2],
                          state.weatherModel.list?[0].main?.humidity
                                  .toString() ??
                              '')
                    ]),
                  ),
                );
              }
              return Container();
            },
            listener: ((context, state) {
              if (state is WeatherErrorState) {
                // в случае ошибки показываю снэкбар
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 10),
                    content: Text(
                      "“Ошибка получения данных",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          color: Colors.red.shade400),
                    ),
                    action: SnackBarAction(
                      textColor: Colors.blueAccent.shade200,
                      label: "Назад",
                      onPressed: (() {
                        Navigator.of(context).pop();
                      }),
                    )));
              }
            })),
      ]),
    );
  }
}
