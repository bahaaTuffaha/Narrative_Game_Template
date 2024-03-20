import 'package:flutter/material.dart';
import 'package:flutter_app/store/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Choices extends ConsumerWidget {
  final List choices;
  final void Function(dynamic) nextDialog;
  final void Function(String) setFinal;
  const Choices(
      {super.key,
      required this.choices,
      required this.nextDialog,
      required this.setFinal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: choices.map((choice) {
            return TextButton(
                onPressed: () => () {
                      nextDialog(
                          choice["GoToDiablock"]); //ref to another diablock
                      setFinal(choice["Text"]);
                      ref.read(store.notifier).state['path'].add(choice[
                          "GoToDiablock"]); //storing the destiny of our player.

                      //print da data
                      debugPrint(ref.watch(store)['path'].toString());
                    }(),
                child: Text(choice["Text"]));
          }).toList()),
    );
  }
}
