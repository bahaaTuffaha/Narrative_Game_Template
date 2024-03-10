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
          speakerName,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          dialogText,
          style: const TextStyle(color: Colors.white),
        )
      ],
    ));
  }
}
