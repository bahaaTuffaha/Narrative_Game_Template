import 'package:flutter/cupertino.dart';
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
  dynamic? chapters;
  var currentDialogs = [];
  int currentChapter = 0;
  bool showContinue = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String data = await rootBundle.loadString('assets/data.yaml');
    setState(() {
      chapters = loadYaml(data);
      chapters = chapters["Chapters"] as List? ?? [];
      currentDialogs.add(chapters[currentChapter]["Diablocks"][0]);
    });
  }

  void nextDialog(var gotoDiablock) {
    setState(() {
      // debugPrint(chapters[currentChapter]["Diablocks"].runtimeType.toString() +
      //     "test pelsea work");
      try {
        var block = chapters[currentChapter]["Diablocks"];
        //has answers
        if (gotoDiablock != null) {
          YamlMap? result = block.firstWhere(
              (element) => element['RefName'] == gotoDiablock,
              orElse: () => null);

          if (result != null) {
            currentDialogs.add(result);
            showContinue = false;
          }
        } else {
          //next to the GoToDiablock
          YamlMap? result = block.firstWhere(
              (element) =>
                  element['RefName'] ==
                  currentDialogs[currentDialogs.length - 1]["GoToDiablock"],
              orElse: () => null);

          if (result != null) {
            currentDialogs.add(result);
            showContinue = true;
          }
        }
        //go to next chapter
        if (currentDialogs[currentDialogs.length - 1]["GoToDiablock"] ==
            "END") {
          currentChapter++;
        }
      } catch (e) {
        debugPrint("error: " + e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (chapters == null) {
      return const CircularProgressIndicator(); // Loading indicator
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dialogBack.png"),
          fit: BoxFit.fill,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.35, // width of the thing
      height: MediaQuery.of(context).size.height - 20,
      child: ListView(children: [
        ...currentDialogs.map((diablock) {
          return DialogBlock(
            speakerName: diablock["Speaker"],
            dialogText: diablock["Dialog"],
            dialogChoices: diablock["Answers"] ?? [],
            nextDialog: nextDialog,
          );
        }),
        InkWell(
            // continue bar
            onTap: () => nextDialog(null),
            child: !showContinue
                ? Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    margin: EdgeInsets.only(bottom: 100),
                    decoration: const BoxDecoration(
                      color: Color(0xff88230C),
                    ),
                    child: const Text(
                      "Continue ►",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Arlt",
                      ),
                    ),
                  )
                : Gap(100))
      ]),
    );
  }
}
