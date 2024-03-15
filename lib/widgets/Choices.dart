import 'package:flutter/material.dart';

class Choices extends StatelessWidget {
  final List choices;
  final void Function(dynamic) nextDialog;
  final void Function(String) setFinal;
  const Choices(
      {super.key,
      required this.choices,
      required this.nextDialog,
      required this.setFinal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: choices.map((choice) {
            return TextButton(
                onPressed: () => () {
                      nextDialog(choice["GoToDiablock"]);
                      setFinal(choice["Text"]);
                    }(),
                child: Text(choice["Text"]));
          }).toList()),
    );
  }
}
