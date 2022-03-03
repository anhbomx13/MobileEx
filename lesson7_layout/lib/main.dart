import 'package:flutter/material.dart';
import './planetBox.dart';
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
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget> [
          Icon(Icons.book),
          Icon(Icons.star_border),
          Icon(Icons.quiz_outlined),
          Icon(Icons.queue_outlined),
        ],
      )
  );

  @override
  Widget build(BuildContext context) {
    final planetList = [
      {
        'name':'Sun',
        'description':'The Sun is the star at the center of the Solar System.',
        'radius':'696.340 km',
        'image':'sun.jpg',
      },
      {
        'name':'Earth',
        'description':'Our home planet Earth is a rocky, terrestrial planet.',
        'radius':'6.371 km',
        'image':'earth.png',
      },
      {
        'name':'Mars',
        'description':'Mars is sometimes called the Red Planet.',
        'radius':'3.389,5 km',
        'image':'mars.jpg',
      },
      {
        'name':'Venus',
        'description':'Venus is the second planet from the Sun.',
        'radius':'6.051,8 km',
        'image':'venus.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
        children: [
        Expanded(
            child: ListView(
                shrinkWrap: true, padding: const EdgeInsets.all(2),
                children: List.generate(planetList.length, (index) {
                  return   PlanetBox(
                          name: planetList[index]['name']!,
                          description : planetList[index]['description']!,
                          image: planetList[index]['image']!,
                          radius: planetList[index]['radius']!,
                      );
                    })
                    
                      ,
                    ),
                ),
        Container(
                child: iconList,
                )
              ],
          ),
    );
  }
}