import 'package:flutter_riverpod/flutter_riverpod.dart';

final store = StateProvider<Map<String, dynamic>>((ref) => {
      'path': [],
      'health': 100,
    });
