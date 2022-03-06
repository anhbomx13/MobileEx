import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Planet extends Model {
  final String name;
  final String description;
  final String image;
  final String radius;
  final String detail;
  int favorite;
  Planet(this.name, this.description, this.image,
      this.radius, this.favorite, this.detail);

  factory Planet.fromMap(Map<String, dynamic> json){
    return Planet(json['name'],
        json['description'],
        json['image'],
        json['radius'],
        json['favorite'],
        json['detail'],
    );
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

    items.add(Planet('The Sun',
        'The Sun is the star at the center of the Solar System.',
        'sun.jpg',
        '696.340 km',
        0,
        'Our Sun is a 4.5 billion-year-old star – a hot glowing ball of hydrogen'
        ' and helium at the center of our solar system. The Sun is about 93 '
        'million miles (150 million kilometers) from Earth, and without its '
        'energy, life as we know it could not exist here on our home planet.\n'
        'The Sun is the largest object in our solar system. The Sun’s volume'
        ' would need 1.3 million Earths to fill it. Its gravity holds the '
        'solar system together, keeping everything from the biggest planets'
        ' to the smallest bits of debris in orbit around it. The hottest'
        ' part of the Sun is its core, where temperatures top 27 million'
        ' degrees Fahrenheit (15 million degrees Celsius). '
        'The Sun’s activity, from its powerful eruptions to the steady '
        'stream of charged particles it sends out, influences the nature '
        'of space throughout the solar system.'));
    items.add(Planet('The Earth',
        'Our home planet Earth is a rocky, terrestrial planet.',
        'earth.png',
        '6.371 km',
        0,
        'Our home planet is the third planet from the Sun, and the only place '
        'we know of so far that’s inhabited by living things.\n'
        'While Earth is only the fifth largest planet in the solar system,'
        ' it is the only world in our solar system with liquid water on the'
        ' surface. Just slightly larger than nearby Venus, Earth is the '
        'biggest of the four planets closest to the Sun, all of which '
        'are made of rock and metal.\n'
        'The name Earth is at least 1,000 years old. All of the planets,'
        ' except for Earth, were named after Greek and Roman gods and '
        'goddesses. However, the name Earth is a Germanic word, which '
        'simply means “the ground.”'));
    items.add(Planet('Mars',
        'Mars is sometimes called the Red Planet.',
        'mars.jpg',
        '3.389,5 km',
        0,
        'Mars is the fourth planet from the Sun – a dusty, cold, desert'
        ' world with a very thin atmosphere. Mars is also a dynamic'
        ' planet with seasons, polar ice caps, canyons, extinct'
        ' volcanoes, and evidence that it was even more active in the past.\n'
        'Mars is one of the most explored bodies in our solar system, '
        'and it\'s the only planet where we\'ve sent rovers to roam '
        'the alien landscape.\n'
        'NASA currently has two rovers (Curiosity and Perseverance), one '
        'lander (InSight), and one helicopter (Ingenuity) exploring the'
        ' surface of Mars.'));
    items.add(Planet('Venus',
        'Venus is the second planet from the Sun.',
        'venus.jpg',
        '6.051,8 km',
        0,
        'Venus is the second planet from the Sun and is Earth’s closest '
        'planetary neighbor. It’s one of the four inner, terrestrial'
        ' (or rocky) planets, and it’s often called Earth’s twin '
        'because it’s similar in size and density. These are not'
        ' identical twins, however – there are radical differences '
        'between the two worlds.\n'
        'Venus has a thick, toxic atmosphere filled with carbon '
        'dioxide and it’s perpetually shrouded in thick, yellowish'
        ' clouds of sulfuric acid that trap heat, causing a runaway'
        ' greenhouse effect. It’s the hottest planet in our solar system,'
        ' even though Mercury is closer to the Sun. Surface temperatures'
        ' on Venus are about 900 degrees Fahrenheit (475 degrees Celsius)'
        ' – hot enough to melt lead. The surface is a rusty color and '
        'it’s peppered with intensely crunched mountains and thousands '
        'of large volcanoes. Scientists think it’s possible some '
        'volcanoes are still active.'));
    items.add(Planet('Neptune',
        'Neptune is the eighth and farthest-known Solar planet from the Sun.',
        'neptune.jpg',
        '24.622 km',
        0,
        'Dark, cold, and whipped by supersonic winds, ice giant Neptune'
            ' is the eighth and most distant planet in our solar system.\n'
            'More than 30 times as far from the Sun as Earth, Neptune '
            'is the only planet in our solar system not visible to the'
            ' naked eye and the first predicted by mathematics before'
            ' its discovery. In 2011 Neptune completed its first 165-year'
            ' orbit since its discovery in 1846.\n'
            'NASA\'s Voyager 2 is the only spacecraft to have visited'
            ' Neptune up close. It flew past in 1989 on its way out of'
            ' the solar system.'));
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
        height: size.height * 0.2,
        child: Card(
            color: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // if you need this
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
              // Image.asset("assets/planet_image/" + item.image,fit: BoxFit.fill,
              //   height: size.height * 0.2, width: size.width * 0.3,),
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

