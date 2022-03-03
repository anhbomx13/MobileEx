import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planet and star',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Planet and star'),
    );
  }
}
// To solve null parameter we use Key? to make it nullable and
// add required to title to make it must be set
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final iconList = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget> [
          Icon(Icons.book),
        ],
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
        children: [
        Expanded(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                  Image.asset('assets/sun.png'),
                        ],
                    ),
                ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                iconList,
              ]
          )
                )
              ],
          ),
    );
  }
}