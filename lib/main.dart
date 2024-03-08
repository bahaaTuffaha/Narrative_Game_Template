import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/home/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

//git remote set-url origin git@github.com:username/repo.git
//git push origin master

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
              Container()
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
