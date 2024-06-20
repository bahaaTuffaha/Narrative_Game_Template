import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/store/riverpod.dart';
import 'package:flutter_app/utils/check_custom_variables.dart';
import 'package:flutter_app/widgets/dialogBlock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter_app/utils/convert.dart';

class NarrativeBar extends ConsumerStatefulWidget {
  NarrativeBar({Key? key}) : super(key: key);

  @override
  ConsumerState<NarrativeBar> createState() => _NarrativeBarState();
}

class _NarrativeBarState extends ConsumerState<NarrativeBar> {
  dynamic? chapters;
  int currentChapter = 0;
  bool showContinue = false;
  final scrollController = ScrollController();
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    loadData();
    isChapterVisible();
  }

  void updateSpeakerImage(String newImagePath) {
    ref.read(store.notifier).state = {
      ...ref.read(store.notifier).state,
      'currentSpeakerImage': newImagePath,
    };
  }

  void updateBackImage(String newImagePath) {
    ref.read(store.notifier).state = {
      ...ref.read(store.notifier).state,
      'Background': newImagePath,
    };
  }

  void isChapterVisible() {
    Future.delayed(Duration(seconds: 4), () {
      ref.read(store.notifier).state = {
        ...ref.read(store.notifier).state,
        'chapterNameVisible': false,
      };
    });
  }

  void updateChapterName(String name) {
    ref.read(store.notifier).state = {
      ...ref.read(store.notifier).state,
      'currentChapterName': name,
      'chapterNameVisible': true,
    };
    isChapterVisible();
  }

  void addDialog(Map dialog) {
    Map newDialog = Map.from(dialog);
    newDialog['isAnswered'] = false;
    newDialog['currentAnswer'] = "";

    ref.read(store.notifier).state['currentDialogs'].add(newDialog);
  }

  void resetDialogs() {
    ref.read(store.notifier).state = {
      ...ref.read(store.notifier).state,
      'currentDialogs': [],
    };
  }

  void addCustomVariable(label, value, color, shortForm) {
    Map newVariable = {};
    newVariable['label'] = label;
    newVariable['value'] = value;
    newVariable['color'] = color;
    newVariable['shortForm'] = shortForm;
    ref.read(store.notifier).state['customVariables'].add(newVariable);
  }

  void addGlobalVariable(myCase, operator, variableName, compareValue) {
    Map newVariable = {};
    newVariable['case'] = myCase;
    newVariable['operator'] = operator;
    newVariable['variableName'] = variableName;
    newVariable['compareValue'] = compareValue;
    ref.read(store.notifier).state['globalConditions'].add(newVariable);
  }

  void customVariableInit(YamlList variableList) {
    for (final variable in variableList) {
      addCustomVariable(variable['label'], variable['value'], variable['color'],
          variable['shortForm']);
    }
  }

  void globalConditionsInit(YamlList conditions) {
    for (final variable in conditions) {
      addGlobalVariable(variable['case'], variable['operator'],
          variable['variableName'], variable['compareValue']);
    }
  }

  void _variableChangeChecker(Map dialog) {
    // Check if dialog contains 'VariableChanges' key
    if (dialog.containsKey('VariableChanges')) {
      for (final variable in dialog['VariableChanges']) {
        final matchingVariable = ref.watch(store)['customVariables'].firstWhere(
              (vari) => vari['label'] == variable['varName'],
              orElse: () => null,
            );

        if (matchingVariable != null) {
          final updatedVariables =
              ref.read(store.notifier).state['customVariables'].toList();
          for (var i = 0; i < updatedVariables.length; i++) {
            if (updatedVariables[i] == matchingVariable) {
              updatedVariables[i] = {
                ...matchingVariable,
                'value': operations(
                  variable['varOperation'],
                  matchingVariable['value'].toDouble(),
                  variable['varValue'].toDouble(),
                ),
              };
              break;
            }
          }
          ref.read(store.notifier).state = {
            ...ref.read(store.notifier).state,
            'customVariables': updatedVariables,
          };
        }
      }
    }

    debugPrint(ref.watch(store)['customVariables'].toString());
  }

  bool _globValueCheck(dynamic globalConds, int index) {
    Map matchingVariable = ref.watch(store)['customVariables'].firstWhere(
          (vari) => vari['label'] == globalConds[index]["variableName"],
          orElse: () => null,
        );
    return checkOperation(globalConds[index]["operator"],
        matchingVariable["value"], globalConds[index]["compareValue"]);
  }

  void _globalConditionChecker() {
    final globalConds =
        ref.read(store.notifier).state['globalConditions'].toList();
    for (var i = 0; i < globalConds.length; i++) {
      switch (globalConds[i]['case']) {
        case 'endgame':
          if (_globValueCheck(globalConds, i)) {
            //GameOver
          }
          break;
        case 'restart':
          if (_globValueCheck(globalConds, i)) {}
          break;
        case 'restartCh':
          if (_globValueCheck(globalConds, i)) {}
          break;
        case 'finished':
          if (_globValueCheck(globalConds, i)) {}
          break;
        default:
      }
    }
  }

  Future<void> loadData() async {
    String data = await rootBundle.loadString('assets/data.yaml');
    String variables =
        await rootBundle.loadString('assets/customVariables.yaml');
    setState(() {
      chapters = loadYaml(data);
      chapters = chapters["Chapters"] as List? ?? [];
      addDialog(chapters[currentChapter]["Diablocks"][0]);
      dynamic customVars = loadYaml(variables);

      customVariableInit(customVars['customVariables']);
      globalConditionsInit(customVars['globalConditions']);
      _globalConditionChecker();

      debugPrint(ref.watch(store)['customVariables'].toString());
    });
    //check if the first diablock has answers
    if (chapters[currentChapter]['Diablocks'][0]["Answers"].length > 0) {
      setState(() {
        showContinue = false;
      });
    }

    updateSpeakerImage(
        chapters[currentChapter]["Diablocks"][0]["SpeakerImage"] ?? "");
    updateBackImage(
        chapters[currentChapter]["Diablocks"][0]["Background"] ?? "");
  }

  void nextDialog(var gotoDiablock) {
    // try {
    var block = chapters[currentChapter]["Diablocks"];
    //has answers
    if (gotoDiablock != null) {
      YamlMap? result = block.firstWhere(
          (element) => element['RefName'] == gotoDiablock,
          orElse: () => null);

      if (result != null) {
        _variableChangeChecker(result); //
        Future.delayed(
            Duration(
                milliseconds:
                    convertSecondsToMilliseconds(result["Delay"] ?? 0)), () {
          setState(() {
            addDialog(result);
            showContinue = true;
          });
          scrollToBottom();

          updateSpeakerImage(result["SpeakerImage"] ?? "");
          updateBackImage(result["Background"] ?? "");
        });
      }
    }
    //go to next chapter
    else if (ref.watch(store)['currentDialogs'].last["GoToDiablock"] == "END") {
      // debugPrint("before" + chapters[currentChapter]["Diablocks"].toString());
      setState(() {
        resetDialogs();
        currentChapter++;
      });
      Future.delayed(
          Duration(
              milliseconds: convertSecondsToMilliseconds(
                  chapters[currentChapter]["Diablocks"][0]["Delay"] ?? 0)), () {
        setState(() {
          addDialog(chapters[currentChapter]["Diablocks"][0]);
        });

        showContinue = true;

        updateChapterName(chapters[currentChapter]["ChapterName"]);
        updateSpeakerImage(
            chapters[currentChapter]["Diablocks"][0]["SpeakerImage"] ?? "");
        updateBackImage(
            chapters[currentChapter]["Diablocks"][0]["Background"] ?? "");
      });
    } else {
      //next to the GoToDiablock
      YamlMap? result = block.firstWhere(
          (element) =>
              element['RefName'] ==
              ref.watch(store)['currentDialogs'].last["GoToDiablock"],
          orElse: () => null);

      if (result != null) {
        // make sure it found the GoToDiablock
        Future.delayed(
            Duration(
                milliseconds:
                    convertSecondsToMilliseconds(result["Delay"] ?? 0)), () {
          setState(() {
            addDialog(result);
            if (result['Answers'] != null) {
              showContinue = false;
            } else {
              showContinue = true;
            }
          });
          scrollToBottom();
          updateSpeakerImage(result["SpeakerImage"] ?? "");
          updateBackImage(result["Background"] ?? "");
        });
      }
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 300,
      duration: Duration(seconds: 1), // Adjust animation duration
      curve: Curves.ease, // Customize animation curve (optional)
    );
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
      child: ListView(
          physics: const ScrollPhysics(),
          controller: scrollController,
          children: [
            ...ref.watch(store)['currentDialogs']?.map((diablock) {
              return DialogBlock(
                  key: ObjectKey(diablock),
                  speakerName: diablock["Speaker"],
                  dialogText: diablock["Dialog"],
                  dialogChoices: diablock["Answers"] ?? [],
                  nextDialog: nextDialog,
                  isAns: diablock['isAnswered'] ?? false,
                  currentAns: diablock['currentAnswer']);
            }),
            InkWell(
                // continue bar
                onTapUp: (TapUpDetails details) =>
                    {player.play(AssetSource("audio/click.mp3"))},
                onTap: () => nextDialog(null),
                child: showContinue
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
