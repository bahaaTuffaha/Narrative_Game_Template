import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blueGrey,
        //   title: const Text("nice"),
        //   titleTextStyle: TextStyle(
        //       color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        // ),
        body: SafeArea(child: Headline("Find the best cooking recipe")),
      ),
    );
  }
}

class Headline extends StatelessWidget {
  final String headTitle;
  Headline(this.headTitle);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.70, //70 percentage width
      child:
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          Text(
        headTitle,
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
      // ]),
    );
  }
}
