import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widgets/dialogBlock.dart';
import 'package:gap/gap.dart';
import 'package:yaml/yaml.dart';

class NarrativeBar extends StatefulWidget {
 NarrativeBar({Key? key}) : super(key: key);

 @override
 State<NarrativeBar> createState() => _NarrativeBarState();
}

class _NarrativeBarState extends State<NarrativeBar> {
 dynamic? yamlData;

 @override
 void initState() {
    super.initState();
    loadData();
 }

 Future<void> loadData() async {
    String data = await rootBundle.loadString('assets/data.yaml');
    setState(() {
      yamlData = loadYaml(data);
    });
 }

 @override
 Widget build(BuildContext context) {
    if (yamlData == null) {
      return CircularProgressIndicator(); // Loading indicator
    }

    var chapters = yamlData["Chapters"] as List? ?? [];
    var chapterWidgets = chapters.map((chapter) {
      var diablocks = chapter["Diablocks"] as List? ?? [];
      var diablockWidgets = diablocks.map((diablock) {

        return DialogBlock(
          speakerName: diablock["Speaker"],
          dialogText: diablock["Dialog"],
          dialogChoices: diablock["Answers"]?? [],
        );
      }).toList();

      return diablockWidgets;
    }).expand((x) => x).toList(); // Flatten the list of lists into a single list

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dialogBack.png"),
          fit: BoxFit.fill,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.35, // width of the thing
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: chapterWidgets,
      ),
    );
 }
}