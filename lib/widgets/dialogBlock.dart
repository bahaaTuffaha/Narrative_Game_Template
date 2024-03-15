import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/FinalAnswer.dart';
import 'package:flutter_app/widgets/choices.dart';

class DialogBlock extends StatefulWidget {
  final String speakerName;
  final String dialogText;
  final List dialogChoices;
  final void Function(dynamic) nextDialog;

  DialogBlock(
      {Key? key,
      required this.speakerName,
      required this.dialogText,
      required this.dialogChoices,
      required this.nextDialog})
      : super(key: key);

  @override
  State<DialogBlock> createState() => _DialogBlockState();
}

class _DialogBlockState extends State<DialogBlock> {
  bool isAnswered = false;
  String currentAnswer = "";

  void setFinalAnswer(String ans) {
    setState(() {
      currentAnswer = ans;
      isAnswered = true;
    });
  }

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
              widget.speakerName.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontFamily: "Arlt", fontSize: 20),
            ),
            Text(
              widget.dialogText,
              style: const TextStyle(
                color: Color(0xffC5CBB6), //0xff + hex
                fontFamily: "Arlt",
                fontSize: 20,
              ),
            )
          ],
        )),
        isAnswered
            ? FinalAnswer(
                finalAnswer: currentAnswer,
              )
            : Choices(
                choices: widget.dialogChoices,
                nextDialog: widget.nextDialog,
                setFinal: setFinalAnswer,
              ),
      ],
    );
  }
}
