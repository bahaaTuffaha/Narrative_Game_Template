import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextChapter extends ConsumerWidget {
  NextChapter({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(store)['chapterNameVisible']
        ? DelayedDisplay(
            fadingDuration: const Duration(seconds: 1),
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
