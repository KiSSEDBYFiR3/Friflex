import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_test_task/core/constants/assets_list.dart';
import 'package:friflex_test_task/feature/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:friflex_test_task/feature/presentation/bloc/weather_cubit/weather_states.dart';
import 'package:friflex_test_task/feature/presentation/widgets/animated_background.dart';
import 'package:friflex_test_task/feature/presentation/widgets/row_tile.dart';

class WeatherForecast extends StatefulWidget {
  final WeatherCubit weatherCubit;
  const WeatherForecast({Key? key, required this.weatherCubit})
      : super(key: key);

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> with ChangeNotifier {
  late final _controller = PageController();
  // счетчик для анимированного контейнера
  ValueNotifier<int> counter = ValueNotifier<int>(0);

  _startBgColorAnimationTimer() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      counter.value++;
    });

    const interval = Duration(seconds: 20);
    Timer.periodic(
      interval,
      (Timer timer) {
        counter.value++;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startBgColorAnimationTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _startBgColorAnimationTimer().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Прогноз',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 32)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, '/second'),
        ),
      ),
      body: BlocBuilder<WeatherCubit, WeatherStates>(
        // так же как и на втором экране передаю экземпляр того же самого кубита, который хранит тоже состояние
        bloc: widget.weatherCubit,
        builder: (context, state) {
          if (state is WeatherLoadedState) {
            return Stack(children: [
              animatedBackground(context, counter.value),
              PageView.builder(
                  itemCount: state.weatherModel.list?.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: detailsPage(
                          context: context,
                          cityName: state.cityName,
                          dateTime: state.weatherModel.list?[index].dtTxt ?? '',
                          // округляю значения до одной цифры после запятой
                          minTemp: state.weatherModel.list?[index].main?.tempMin
                                  ?.toStringAsFixed(1) ??
                              '',
                          windSpeed: state.weatherModel.list?[index].wind?.speed
                                  ?.toStringAsFixed(1) ??
                              '',
                          humidity: state
                                  .weatherModel.list?[index].main?.humidity
                                  ?.toStringAsFixed(1) ??
                              ''),
                    );
                  }),
            ]);
          }
          return Container();
        },
      ),
    );
  }

  Widget detailsPage(
      {required BuildContext context,
      required String cityName,
      required String dateTime,
      required String minTemp,
      required String windSpeed,
      required String humidity}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.cyan.shade50.withOpacity(0.3)),
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(children: [
        Center(
          child: Text(
            cityName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontSize: 36),
          ),
        ),
        Center(
          child: Text(
            dateTime,
            style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontFamily: 'Montserrat',
                fontSize: 24),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        rowTile(context, AssetsPath.assetsList[0], minTemp),
        rowTile(context, AssetsPath.assetsList[1], windSpeed),
        rowTile(context, AssetsPath.assetsList[2], humidity),
      ]),
    );
  }
}
