import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextChapter extends ConsumerStatefulWidget {
  NextChapter({Key? key}) : super(key: key);

  @override
  _NextChapterState createState() => _NextChapterState();
}

class _NextChapterState extends ConsumerState<NextChapter> {
  double opacity = 0;
  bool localChecker = true;

  void start() {
    fadeIn();
    Future.delayed(Duration(milliseconds: 2500), () {
      fadeOut();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fadeIn() {
    setState(() {
      opacity = 1;
    });
  }

  void fadeOut() {
    setState(() {
      opacity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(store)['chapterNameVisible'] && localChecker) {
      setState(() {
        Future.delayed(Duration(milliseconds: 500), () {
          start();
          setState(() {
            localChecker = false;
          });
        });
      });
    }
    if (ref.watch(store)['chapterNameVisible'] == false) {
      setState(() {
        localChecker = true;
      });
    }
    return ref.watch(store)['chapterNameVisible']
        ? AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: opacity,
            child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DelayedDisplay(
                    fadingDuration: Duration(seconds: 1),
                    child: Text("CHAPTER",
                        style: TextStyle(
                          color: Color(0xffC5CBB6), //0xff + hex
                          fontFamily: "Arlt",
                          fontSize: 60,
                        )),
                  ),
                  DelayedDisplay(
                    delay: const Duration(seconds: 1),
                    child: Text(ref.watch(store)['currentChapterName'],
                        style: const TextStyle(
                          color: Color(0xffC5CBB6), //0xff + hex
                          fontFamily: "Arlt",
                          fontSize: 30,
                        )),
                  ),
                ],
              )),
            ))
        : const SizedBox.shrink();
  }
}
