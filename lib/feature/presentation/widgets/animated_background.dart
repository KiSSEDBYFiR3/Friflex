import 'package:flutter/material.dart';

// При каждом новом обращении перемешиваем список
// Таким образом градиент каждый раз немного разный
List<Color> get colorsList => [
      Colors.indigoAccent.shade100,
      const Color.fromARGB(255, 0, 48, 80),
      const Color.fromARGB(255, 0, 95, 71),
      const Color.fromARGB(255, 8, 87, 177),
      const Color.fromARGB(255, 69, 125, 228),
      const Color.fromARGB(255, 43, 121, 113),
    ]..shuffle();

List<Alignment> alignments = [
  Alignment.bottomLeft,
  Alignment.bottomRight,
  Alignment.topRight,
  Alignment.topLeft,
];

Widget animatedBackground(BuildContext context, int counter) {
  return Scaffold(
      body: Stack(children: [
    AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // в экранах со стейтфул виджетами алайнменты меняются в зависимости от значения счетчика
          // в стейтлесс виджете можно выбрать просто любое значение счетчика по умолчанию
          begin: alignments[counter % alignments.length],
          end: alignments[(counter + 2) % alignments.length],
          colors: colorsList,
          tileMode: TileMode.mirror,
        ),
      ),
      duration: const Duration(seconds: 30),
      curve: Curves.bounceInOut,
    ),
    Container(height: MediaQuery.of(context).size.height)
  ]));
}
