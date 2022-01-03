import 'package:gestion_de_stock/app/models/materiel.dart';
import 'package:gestion_de_stock/app/models/membre.dart';
import 'package:gestion_de_stock/app/services/config/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Materielservice {
  static Future<bool> add(Materiel mat) async {
    Database db = await Mydatabase.getDatabase();
    List<Map> material = await db.query("MATERIEL",
        where: "nomMateriel=? and quantite=? and dateAcquisition=? and nomF=?",
        whereArgs: [
          mat.nomMateriel,
          mat.quantite,
          mat.dateAcqui!.microsecondsSinceEpoch,
          mat.nomF
        ]);
    if (material.isEmpty) {
      await db.insert("MATERIEL", mat.toMap());
      return true;
    }
    return false;
  }

  static Future<List<Materiel>> getAllMaterial() async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, Object?>> mapMaterial = await db.query("MATERIEL");
    List<Materiel> allMaterial = [];
    mapMaterial
        .forEach((element) => allMaterial.add(Materiel.fromMap(element)));
    return allMaterial;
  }

  static Future<bool> borrowMaterial(Member mem, Materiel mat) async {
    Database db = await Mydatabase.getDatabase();
    mat.quantite = mat.quantite! - mem.quantite!;
    await db.insert("MEMBERS", mem.toMap());
    await db
        .update("MATERIEL", mat.toMap(), where: "id = ?", whereArgs: [mat.id]);
    return true;
  }

  static Future<List<Member>> getAllMember() async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, Object?>> mapMembers = await db.query("MEMBERS");
    List<Member> allMembers = [];
    mapMembers.forEach((element) => allMembers.add(Member.fromMap(element)));
    return allMembers;
  }

  static Future<Materiel> getMaterialById(int id) async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, Object?>> map =
        await db.query("MATERIEL", where: "id = ?", whereArgs: [id]);
    return Materiel.fromMap(map.first);
  }

  static Future<List<Materiel>> getMaterialByNomF(String nomF) async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, dynamic>> materials =
        await db.query("MATERIEL", where: "nomF = ?", whereArgs: [nomF]);
    List<Materiel> allMaterial = [];
    materials.forEach((element) => allMaterial.add(Materiel.fromMap(element)));
    return allMaterial;
  }

  static Future<bool> returnBorrow(Member mem) async {
    Database db = await Mydatabase.getDatabase();
    await db
        .update("MEMBERS", mem.toMap(), where: "id = ?", whereArgs: [mem.id]);
    return true;
  }
}
