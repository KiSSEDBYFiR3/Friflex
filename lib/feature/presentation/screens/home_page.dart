import 'dart:async';
import 'package:flutter/material.dart';
import 'package:friflex_test_task/feature/presentation/bloc/weather_cubit/weather_cubit.dart';
import 'package:friflex_test_task/feature/presentation/widgets/animated_background.dart';

class HomePage extends StatefulWidget {
  final WeatherCubit weatherCubit;

  const HomePage({
    Key? key,
    required this.weatherCubit,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ключ формы для прохлждения валидации поля ввода
  final _formKey = GlobalKey<FormFieldState>();
  // "ленивая" инициализация контроллера
  late final TextEditingController _cityNameController =
      TextEditingController();
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
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        animatedBackground(context, counter.value),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 300,
            child: TextFormField(
              style: const TextStyle(color: Color.fromARGB(234, 255, 255, 255)),
              key: _formKey,
              validator: (value) {
                // валидация поля ввода
                // если поле ввода пустое, выводим ошибку
                if (value == null || value.isEmpty) {
                  return "Поле не должно быть пустым";
                  // если значение поля ввода короче двух символов, так же выводим ошибку
                } else if (value.length < 2) {
                  return "Слишком короткое название";
                }
                return null;
              },
              controller: _cityNameController,
              autofocus: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(234, 255, 255, 255)),
                  labelText: "Название города",
                  floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 30, left: 80, right: 80),
              child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: const Color.fromRGBO(30, 215, 96, 1),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        // если поле прошло валидацию, переходим на следующую страницу и делаем запрос данных через Cubit
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/second');
                          widget.weatherCubit
                              .fetchForecast(_cityNameController.text);
                        }
                      },
                      child: const Center(
                          child: Text("Подтвердить",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat",
                                  color: Colors.white)))))),
        ])
      ]),
    );
  }
}
