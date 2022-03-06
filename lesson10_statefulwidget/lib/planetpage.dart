import 'package:flutter/material.dart';
import './planetBox.dart';

class PlanetPage extends StatelessWidget {
  PlanetPage({Key? key,required this.item}): super(key: key);
  final Planet item;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),

      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/planet_image/" + item.image),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(2),
                    child: Column(
                      children: [
                        Text("Description: " + item.description),
                      ],
                    ),
                  )
              )
            ],
          )
        )
      ),

    );
  }
}