import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import './planetBox.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await
    getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "PlanetDB.db");
    return await openDatabase(
        path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE Planet ("
                  "id INTEGER PRIMARY KEY,"
                  "name TEXT,"
                  "description TEXT,"
                  "image TEXT,"
                  "radius TEXT,"
                  "favorite INTEGER,"
                  "detail TEXT"
                  ")"
          );
          await db.execute(
              "INSERT INTO Planet ('id', 'name', 'description', 'image', 'radius','favorite','detail') values (?, ?, ?, ?, ?,?,?)",
          [1, "Sun", "The Sun is the star at the center of the Solar System."
            , "sun.jpg", "696.340 km",0,
            "Our Sun is a 4.5 billion-year-old star – a hot glowing ball of hydrogen and helium at the center of our solar system. The Sun is about 93 million miles (150 million kilometers) from Earth, and without its energy, life as we know it could not exist here on our home planet.\nThe Sun is the largest object in our solar system. The Sun’s volume would need 1.3 million Earths to fill it. Its gravity holds the solar system together, keeping everything from the biggest planets to the smallest bits of debris in orbit around it. The hottest part of the Sun is its core, where temperatures top 27 million degrees Fahrenheit (15 million degrees Celsius). The Sun’s activity, from its powerful eruptions to the steady stream of charged particles it sends out, influences the nature of space throughout the solar system."]
          );

          await db.execute(
              "INSERT INTO Planet ('id', 'name', 'description', 'image', 'radius','favorite','detail') values (?, ?, ?, ?, ?,?,?)",
              [2, "Earth", "Our home planet Earth is a rocky, terrestrial planet."
                , "earth.gif", "6.371 km",0,
          "Our home planet is the third planet from the Sun, and the only place we know of so far that’s inhabited by living things.\nWhile Earth is only the fifth largest planet in the solar system, it is the only world in our solar system with liquid water on the surface. Just slightly larger than nearby Venus, Earth is the biggest of the four planets closest to the Sun, all of which are made of rock and metal.\nThe name Earth is at least 1,000 years old. All of the planets, except for Earth, were named after Greek and Roman gods and goddesses. However, the name Earth is a Germanic word, which simply means “the ground."
          ]);

        }
    );
  }
  Future<List<Planet>> getAllPlanets() async {
    final db = await database;
    List<Map> results = await db!.query(
        "Planet", columns: Planet.columns, orderBy: "id ASC"
    );
    List<Planet> planets = [];
    var result;
    for (result in results){
      Planet planet = Planet.fromMap(result);
      planets.add(planet);
    };
    return planets;
  }
  Future<Planet?> getPlanetById(int id) async {
    final db = await database;
    var result = await db!.query("Planet", where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Planet.fromMap(result.first) : null;
  }
  insert(Planet planet) async {
    final db = await database;
    var maxIdResult = await db!.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Planet");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into Planet (id, name, description, image, radius, favorite, detail)"
            " VALUES (?, ?, ?, ?, ?, ?, ?)",
        [id, planet.name, planet.description, planet.image, planet.radius, planet.favorite, planet.detail]
    );
    return result;
  }
  update(Planet planet) async {
    final db = await database;
    var result = await db!.update(
        "Planet", planet.toMap(), where: "id = ?", whereArgs: [planet.id]
    );
    return result;
  }
  delete(int id) async {
    final db = await database;
    db!.delete("Planet", where: "id = ?", whereArgs: [id]);
  }
}
