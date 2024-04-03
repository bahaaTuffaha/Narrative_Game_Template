import 'package:flutter_riverpod/flutter_riverpod.dart';

final store = StateProvider<Map<String, dynamic>>((ref) => {
      'currentSpeakerImage': "",
      'Background': "",
      'path': [], // history of your choices
      'currentChapterName': "Start",
      'chapterNameVisible': true,
      'health': 100,
    });
