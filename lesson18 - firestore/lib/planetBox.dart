import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Planet extends Model {
  final int id;
  final String name;
  final String description;
  final String image;
  final String radius;
  final String detail;
  int favorite;
  static final columns = ["id", "name", "description", "image", "radius","detail"];
  Planet(this.id, this.name, this.description, this.image,
      this.radius, this.favorite, this.detail);

  factory Planet.fromMap(Map<String, dynamic> json){
    return Planet(
        json['id'],
        json['name'],
        json['description'],
        json['image'],
        json['radius'],
        json['favorite'],
        json['detail'],
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "radius": radius,
    "favorite":favorite,
    "detail": detail
  };

void updateFavorite(){
    if (favorite == 0) {
      favorite = 1;
    }
    else {
      favorite = 0;
    }
      notifyListeners();
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
        height: size.height * 0.23,
        child: Card(
            color: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: Colors.redAccent.withOpacity(0.2),
                width: 2,
              ),
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: size.height * 0.22,
                width: size.width * 0.22,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/planet_image/" + item.image),
                  ),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: ScopedModel<Planet>(
                      model: this.item,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Name: " + item.name,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("Description: " + item.description,
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Radius: " + item.radius,
                            style: TextStyle(color: Colors.white),),
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

