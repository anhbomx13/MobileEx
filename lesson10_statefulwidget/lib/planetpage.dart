import 'package:flutter/material.dart';
import './planetBox.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class PlanetPage extends StatelessWidget {
  PlanetPage({Key? key,required this.item}): super(key: key);
  final Planet item;
  static const platform = const MethodChannel('flutterapp.tutorialspoint.com/browser');
  Future<void> _openBrowser() async {
    try {
      final int result = await platform.invokeMethod('openBrowser', <String, String>{
        'url': "https://flutter.dev"
      });
    }
    on PlatformException catch (e) {
      // Unable to open the browser print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),

      body:
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/planet_image/pageBg.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(2),
            children: [
              SizedBox(
                height: size.height * 0.4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 10, color: Colors.redAccent, spreadRadius: 5)],
                  ),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/planet_image/" + item.image),
                  ),
                )
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(item.name,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.white70, fontSize: 30),),
                        Text("\"" + item.description + "\"\n",
                          style: TextStyle(fontStyle: FontStyle.italic,
                              color: Colors.white70, fontSize: 17),),
                        Text('Detail:\n' + item.detail,
                            style: TextStyle(color: Colors.white70, fontSize: 15)),
                      ],
                    ),
                  )
              ),
              ElevatedButton(
                onPressed: _openBrowser,
                child: Text('More detail'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white12,
                  shadowColor: Colors.white38,
                  minimumSize: Size(10, 25),
                ),
              ),
            ],
          )
        )
    );
  }
}