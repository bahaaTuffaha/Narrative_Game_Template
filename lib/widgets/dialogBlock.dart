import 'package:flutter/material.dart';

class DialogBlock extends StatelessWidget {
  final String speakerName;
  final String text;

  const DialogBlock({Key? key, required this.speakerName, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(speakerName,style: const TextStyle(color:Colors.white),
    )
    );
  }
}