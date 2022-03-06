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
  final items = Planet.getPlanetBoxs();
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
    void _showDialog(BuildContext context) {
      // user defined function void _showDialog(BuildContext context) {
      // flutter defined function
      showDialog(
        context: context, builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Message"),
          content: const Text("Clicked"),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
        children: [
        Expanded(
            child: ListView.builder(
                shrinkWrap: true, padding: const EdgeInsets.all(2),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return PlanetBox(item: items[index]);
                },
            )
        ),
              // children: List.generate(planetList.length, (index) {
              //
              //     return
              //       GestureDetector(
              //         onTap: () { _showDialog(context);},
              //         child: Planet(
              //             name: planetList[index]['name']!,
              //             description : planetList[index]['description']!,
              //             image: planetList[index]['image']!,
              //             radius: planetList[index]['radius']!,
              //           )
              //         );
              //       })
              //
              //         ,
              //       ),
              //   ),
        Container(
                child: iconList,
                )
              ],
          ),
    );
  }
}