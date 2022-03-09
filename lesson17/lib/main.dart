import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './planetBox.dart';
import './planetpage.dart';
void main() => runApp(MyApp(items: fetchPlanets()));

List<Planet> parsePlanets(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Planet>((json) => Planet.fromJSON(json)).toList();
}
Future<List<Planet>> fetchPlanets() async {
  final response = await http.get(Uri.parse('http://192.168.37.1:8000/planet.JSON'));
  if (response.statusCode == 200) {
    return parsePlanets(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<List<Planet>>  items;
  MyApp({Key? key,required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planet and star',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Planet and star', items: items),
    );
  }
}
// To solve null parameter we use Key? to make it nullable and
// add required to title to make it must be set
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title, required this.items}) : super(key: key);
  final String title;
  final Future<List<Planet>>  items;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff6600ff),
      body:
      Container(
        child :Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: [
                  Text('Planet',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('and',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('Star',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(width: 70),
                  IconButton(onPressed: (){},
                      icon: Icon(Icons.menu),
                      color: Colors.white),
                  SizedBox(height: 100,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 20.0, top: 20.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/planet_image/homeBg.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(75.0))
                ),
                child: Expanded(
                    child: FutureBuilder<List<Planet>>(
                      future: items, builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData ? PlanetBoxList(items: snapshot.data!)

                      // return the ListView widget :
                      : const Center(child: CircularProgressIndicator());
                    },
                    ),
              ),
            ),
            ),
                ],
            ),
      ),
    );
  }
}
class PlanetBoxList extends StatelessWidget {
  final List<Planet> items;
  PlanetBoxList({Key? key,required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  alignment: Alignment.center,
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
    );
  }
}
