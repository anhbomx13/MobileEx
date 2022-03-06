import 'package:flutter/material.dart';
import './planetBox.dart';
import './planetpage.dart';
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
          Icon(Icons.book, color: Colors.white70,),
          Icon(Icons.star_border, color: Colors.white70),
          Icon(Icons.quiz_outlined, color: Colors.white70),
          Icon(Icons.queue_outlined, color: Colors.white70),
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
      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/planet_image/homeBg.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child :Column(
          children: [
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true, padding: const EdgeInsets.all(2),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return  GestureDetector(
                      child: PlanetBox(item: items[index]),
                      onTap: () {
                        Navigator.push(context, PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 300),
                            transitionsBuilder: (context,
                            Animation<double> animation,
                            Animation<double> animation2, Widget child){
                              return ScaleTransition(
                                alignment: Alignment.topLeft,
                                scale: animation,
                                child: child,
                              );
                            }, pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation)
                            {
                              return PlanetPage(item: items[index]);
                            },
                          ),
                        );
                      },
                    );
                  },
              )
          ),
          Container(
                  child: iconList,
                  )
                ],
            ),
      ),
    );
  }
}