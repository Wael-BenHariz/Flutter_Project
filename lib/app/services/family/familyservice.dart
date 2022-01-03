import 'package:gestion_de_stock/app/models/famille.dart';
import 'package:gestion_de_stock/app/services/config/database_connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Familyservice {
  static Future<bool> add(Famille fam) async {
    Database db = await Mydatabase.getDatabase();
    List<Map> family = await db
        .query("FAMILY", where: "familyname = ?", whereArgs: [fam.familyname]);
    if (family.isEmpty) {
      print(fam.toMap());
      await db.insert("FAMILY", fam.toMap());
      return true;
    }
    return false;
  }

  static Future<List<Famille>> getAllFamily() async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, Object?>> mapFamilly = await db.query("FAMILY");
    List<Famille> allFamilly = [];
    mapFamilly.forEach((element) => allFamilly.add(Famille.fromMap(element)));
    return allFamilly;
  }
}
