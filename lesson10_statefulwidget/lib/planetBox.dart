import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Planet extends Model {
  final String name;
  final String description;
  final String image;
  final String radius;
  int favorite;
  Planet(this.name, this.description, this.image, this.radius, this.favorite);

  factory Planet.fromMap(Map<String, dynamic> json){
    return Planet(json['name'],
        json['description'],
        json['image'],
        json['radius'],
        json['favorite']);
  }

  void updateFavorite(){
    if (favorite == 0) {
      favorite = 1;
    }
    else {
      favorite = 0;
    }
      notifyListeners();
  }

  static List<Planet> getPlanetBoxs() {
    List<Planet> items = <Planet> [];

    items.add(Planet('Sun',
        'The Sun is the star at the center of the Solar System.',
        'sun.jpg',
        '696.340 km',
        0));
    items.add(Planet('Earth',
        'Our home planet Earth is a rocky, terrestrial planet.',
        'earth.png',
        '6.371 km',
        0));
    items.add(Planet('Mars',
        'Mars is sometimes called the Red Planet.',
        'mars.jpg',
        '3.389,5 km',
        0));
    items.add(Planet('Venus',
        'Venus is the second planet from the Sun.',
        'venus.jpg',
        '6.051,8 km',
        0));
    return items;
  }
}

class FavoriteBox extends StatelessWidget {
  FavoriteBox({Key? key, required this.item}): super(key: key);
  final Planet item;
  Widget build(BuildContext context) {
    double _size = 20;
    return Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon:  (item.favorite == 0 ? Icon(Icons.favorite_border, size : _size,):
            Icon(Icons.favorite, size: _size)),
          color: Colors.red[500],
          onPressed: () => this.item.updateFavorite(),
          iconSize: _size,
        ),
    );
  }
}

class PlanetBox extends StatelessWidget{
  PlanetBox({Key? key, required this.item}): super (key : key);
  final Planet item;

  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.all(2),
        height: 120,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/planet_image/" + item.image,fit: BoxFit.fill,
                height: size.height * 0.2, width: size.width * 0.3,),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: ScopedModel<Planet>(
                      model: this.item,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Name: " + item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Description: " + item.description, style: TextStyle(fontStyle: FontStyle.italic),),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Radius: " + item.radius),
                              ScopedModelDescendant<Planet>(
                                  builder: (context, child, item)
                                  {
                                    return FavoriteBox(item: item);
                                  }
                              )
                            ],
                          )
                        ]
                    )
                  )
                )
              )
            ]
          )
        )
      );
  }
}

