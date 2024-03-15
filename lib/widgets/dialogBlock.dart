import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/Choices.dart';

class DialogBlock extends StatelessWidget {
  final String speakerName;
  final String dialogText;
  final List dialogChoices;
  final void Function(dynamic) nextDialog;

  const DialogBlock(
      {Key? key,
      required this.speakerName,
      required this.dialogText,
      required this.dialogChoices,
      required this.nextDialog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
        )),
        Choices(
          choices: dialogChoices,
          nextDialog: nextDialog,
        ),
      ],
    );
  }
}
