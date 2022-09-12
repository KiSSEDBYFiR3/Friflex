import 'package:flutter/material.dart';

Widget rowTile(BuildContext context, String imagePath, String weatherText) {
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 10, left: 15),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        Text(
          weatherText,
          style: const TextStyle(
              color: Colors.black, fontSize: 42, fontFamily: "Montserrat"),
        ),
      ],
    ),
  );
}
