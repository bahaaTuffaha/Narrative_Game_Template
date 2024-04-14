import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/Choices.dart';
import 'package:flutter_app/widgets/FinalAnswer.dart';

class DialogBlock extends StatefulWidget {
  final String speakerName;
  final String dialogText;
  final List dialogChoices;
  final bool isAns;
  final String currentAns;
  final void Function(dynamic) nextDialog;

  DialogBlock({
    Key? key,
    required this.speakerName,
    required this.dialogText,
    required this.dialogChoices,
    required this.nextDialog,
    required this.isAns,
    required this.currentAns,
  }) : super(key: key);

  @override
  State<DialogBlock> createState() => _DialogBlockState();
}

class _DialogBlockState extends State<DialogBlock> {
  // bool isAnswered = false;
  // String currentAnswer = "";

  // void setFinalAnswer(String ans) {
  //   setState(() {
  //     currentAnswer = ans;
  //     isAnswered = true;
  //   });
  // }

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
            SizedBox(
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Color(0xffC5CBB6), //0xff + hex
                  fontFamily: "Arlt",
                  fontSize: 20,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                  animatedTexts: [
                    TyperAnimatedText(widget.dialogText),
                  ],
                ),
              ),
            )
          ],
        )),
        widget.isAns
            ? FinalAnswer(
                finalAnswer: widget.currentAns,
              )
            : Choices(
                choices: widget.dialogChoices,
                nextDialog: widget.nextDialog,
              ),
      ],
    );
  }
}
