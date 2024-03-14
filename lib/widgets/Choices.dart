import 'package:flutter/material.dart';

class Choices extends StatelessWidget {
  final List choices;
  const Choices({super.key, required this.choices});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: choices.map((choice) {
        return TextButton(onPressed: ()=>{}, child:Text(choice["Text"]));
      
      }).toList()
      ),
    );
  }
}