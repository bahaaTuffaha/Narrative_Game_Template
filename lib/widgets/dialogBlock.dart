import 'package:flutter/material.dart';

class DialogBlock extends StatelessWidget {
  final String speakerName;
  final String dialogText;

  const DialogBlock(
      {Key? key, required this.speakerName, required this.dialogText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          speakerName.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontFamily: "Arlt", fontSize: 20),
        ),
        Text(
          dialogText,
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
