import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/store/riverpod.dart';
import 'package:flutter_app/widgets/sidebar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

//git remote set-url origin git@github.com:username/repo.git
//git push origin master

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blueGrey,
        //   title: const Text("nice"),
        //   titleTextStyle: TextStyle(
        //       color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height, //double.infinity
                width: MediaQuery.of(context).size.width,
                // width: MediaQuery.of(context).size.width * 0.65,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/lev1_back.jpg"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                right: 0,
                child: NarrativeBar(),
              ),
              ref.watch(store)['currentSpeakerImage'] != ""
                  ? Positioned(
                      right: (MediaQuery.of(context).size.width * 0.35),
                      top: 20,
                      child: Container(
                        width: 120,
                        height: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ref
                                    .watch(store)['currentSpeakerImage']
                                    .toString()),
                                fit: BoxFit.cover),
                            border: const Border.symmetric(
                                horizontal: BorderSide(
                                    width: 5, color: Color(0xff232221)),
                                vertical: BorderSide(
                                    width: 5, color: Color(0xff232221))),
                            color: Color(0xff232221)),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.business), label: 'business')
        //   ],
        // ),
        // drawer: const Drawer(
        //   child: Text("Yo"),
        // ),
      ),
    );
  }
}
