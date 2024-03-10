import 'package:flutter_app/widgets/dialogBlock.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import '../models/levels.dart';

class NarrativeBar extends StatefulWidget {
  NarrativeBar({Key? key}) : super(key: key);

  @override
  State<NarrativeBar> createState() => _NarrativeBarState();
}

class _NarrativeBarState extends State<NarrativeBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(color: Colors.amber),
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/dialogBack.png"),fit: BoxFit.fill,)
      ),
      width: 250,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: level1.entries.map((entry) {
         return Column(children: [DialogBlock(
            speakerName: entry.key,
            dialogText: entry.value,
          ),const Gap(20)],crossAxisAlignment: CrossAxisAlignment.start,);
           
        }).toList(),
      ),
      );
  }
}
