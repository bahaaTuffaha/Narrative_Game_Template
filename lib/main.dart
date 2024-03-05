import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/home/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
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
            child: Column(
          children: [
            Headline("Find the best cooking recipe"),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                  child: Text("sad"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }),
            )
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), label: 'business')
          ],
        ),
        drawer: const Drawer(
          child: Text("Yo"),
        ),
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
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
      // ]),
    );
  }
}
