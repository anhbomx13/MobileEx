import 'package:flutter/material.dart';

class PlanetBox extends StatelessWidget {
  PlanetBox({Key? key,required this.description,required this.name,required this.image,required this.radius})
  : super (key : key);
  final String name;
  final String description;
  final String image;
  final String radius;
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.all(2),
        height: 120,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/planet_image/" + image,fit: BoxFit.fill,
                height: size.height * 0.2, width: size.width * 0.3,),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Name: " + this.name, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Description: " + this.description, style: TextStyle(fontStyle: FontStyle.italic),),
                          Text("Radius: " + this.radius),
                        ],
                      ),
                 ),
              ),
            ],
          ),
        ),
    );
  }
}
