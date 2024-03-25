import 'package:flutter_riverpod/flutter_riverpod.dart';

final store = StateProvider<Map<String, dynamic>>((ref) => {
      'currentSpeakerImage': "",
      'currentBackgroundImage': "",
      'path': [], // history of your choices
      'health': 100,
    });
