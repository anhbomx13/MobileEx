import 'package:flutter/material.dart';
import './planetBox.dart';
import './planetpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp( MyApp());
}


Stream<QuerySnapshot> fetchPlanets() {
  return FirebaseFirestore.instance.collection('item').snapshots(); }


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: fetchPlanets(), builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    if(snapshot.hasData) {
                      final documents = snapshot.data!.docs;
                      List<Planet> items = [];
                      for(var i = 0; i < documents.length; i++) {
                        DocumentSnapshot document = documents[i];
                        items.add(Planet.fromMap(document.data() as Map<String, dynamic>));
                      }
                      return PlanetBoxList(items: items);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
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
