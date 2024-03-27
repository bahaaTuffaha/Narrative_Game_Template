import 'package:flutter/material.dart';

class FadeInBackground extends StatefulWidget {
  // final Widget child;
  String background = ""; // to check if the background changed
  FadeInBackground({Key? key, required this.background}) : super(key: key);

  @override
  _FadeInBackgroundState createState() => _FadeInBackgroundState();
}

class _FadeInBackgroundState extends State<FadeInBackground> {
  double opacity = 0;
  String oldBack = "";

  @override
  void initState() {
    super.initState();
    triggerFadeIn();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void triggerFadeIn() {
    oldBack = widget.background;
    fadeIn();
    setState(() {});
  }

  void fadeIn() {
    opacity = 1;
  }

  void fadeOut() {
    opacity = 0;
  }

  @override
  void didUpdateWidget(FadeInBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.background != oldWidget.background) {
      fadeOut();
      Future.delayed(Duration(seconds: 1), () {
        triggerFadeIn();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: opacity,
      child: oldBack.isNotEmpty
          ? Container(
              height: MediaQuery.of(context).size.height, //double.infinity
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(oldBack), fit: BoxFit.cover)),
            )
          : Container(
              height: MediaQuery.of(context).size.height, //double.infinity
              width: MediaQuery.of(context).size.width),
    );
  }
}
