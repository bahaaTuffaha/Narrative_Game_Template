import 'package:flutter/services.dart';
import 'package:flutter_app/widgets/dialogBlock.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import '../models/levels.dart';
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
    // called once
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
    print(yamlData?["Chapters"][0]["Diablocks"][0]);
    return Container(
      // decoration: BoxDecoration(color: Colors.amber),
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/dialogBack.png"),
        fit: BoxFit.fill,
      )),
      width: MediaQuery.of(context).size.width * 0.35, // width of the thing
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: level1.entries.toList().asMap().entries.map((entry) {
          //each entry has been put in new entry with key so we can use it as index
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DialogBlock(
                speakerName: entry.value.key + "${entry.key}",
                dialogText: entry.value.value,
              ),
              const Gap(20)
            ],
          );
        }).toList(),
      ),
    );
  }
}
