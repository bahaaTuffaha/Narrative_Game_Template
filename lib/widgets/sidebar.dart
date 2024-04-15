import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/store/riverpod.dart';
import 'package:flutter_app/widgets/dialogBlock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:yaml/yaml.dart';

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

  Future<void> loadData() async {
    String data = await rootBundle.loadString('assets/data.yaml');
    setState(() {
      chapters = loadYaml(data);
      chapters = chapters["Chapters"] as List? ?? [];
      addDialog(chapters[currentChapter]["Diablocks"][0]);
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
        setState(() {
          addDialog(result);
          showContinue = true;
        });
        updateSpeakerImage(result["SpeakerImage"] ?? "");
        updateBackImage(result["Background"] ?? "");
        scrollToBottom();
      }
    }
    //go to next chapter
    else if (ref.watch(store)['currentDialogs'].last["GoToDiablock"] == "END") {
      debugPrint("before" + chapters[currentChapter]["Diablocks"].toString());
      setState(() {
        resetDialogs();
        currentChapter++;
      });
      debugPrint(
          "after clearing" + chapters[currentChapter]["Diablocks"].toString());

      // debugPrint(chapters[currentChapter]["Diablocks"][0]['Dialog']);
      setState(() {
        addDialog(chapters[currentChapter]["Diablocks"][0]);
      });
      debugPrint("after cleaning and adding dialog" +
          chapters[currentChapter]["Diablocks"].toString());
      showContinue = true;

      updateChapterName(chapters[currentChapter]["ChapterName"]);
      updateSpeakerImage(
          chapters[currentChapter]["Diablocks"][0]["SpeakerImage"] ?? "");
      updateBackImage(
          chapters[currentChapter]["Diablocks"][0]["Background"] ?? "");
    } else {
      //next to the GoToDiablock
      YamlMap? result = block.firstWhere(
          (element) =>
              element['RefName'] ==
              ref.watch(store)['currentDialogs'].last["GoToDiablock"],
          orElse: () => null);

      if (result != null) {
        // make sure it found the GoToDiablock
        setState(() {
          addDialog(result);
          if (result['Answers'] != null) {
            showContinue = false;
          } else {
            showContinue = true;
          }
        });
        updateSpeakerImage(result["SpeakerImage"] ?? "");
        updateBackImage(result["Background"] ?? "");
        scrollToBottom();
      }
    }
    // } catch (e) {
    //   debugPrint("error: " + e.toString());
    // }
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
