import 'package:flutter/material.dart';

class FinalAnswer extends StatelessWidget {
  final String finalAnswer;
  const FinalAnswer({super.key, required this.finalAnswer});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "YOU",
          style:
              TextStyle(color: Colors.white, fontFamily: "Arlt", fontSize: 20),
        ),
        Text(
          finalAnswer,
          style: const TextStyle(
            color: Color(0xffC5CBB6), //0xff + hex
            fontFamily: "Arlt",
            fontSize: 20,
          ),
        )
      ],
    ));
  }
}
