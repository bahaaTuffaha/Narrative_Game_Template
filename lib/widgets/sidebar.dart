import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

class NarrativeBar extends StatefulWidget {
  NarrativeBar({Key? key}) : super(key: key);

  @override
  State<NarrativeBar> createState() => _NarrativeBarState();
}

class _NarrativeBarState extends State<NarrativeBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: MediaQuery.of(context).size.height,
      child: Image(
        image: AssetImage("assets/images/dialogBack.png"),
      ),
    );
  }
}
