import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Mydatabase {
  static const databaseName = "gestionComposant.db";
  static const databaseVersion = 1;
  static Database? _database;

  static Future<Database> getDatabase() async {
    return _database ??= await initDatabase();
  }

  static Future<Database> initDatabase() async {
    String documentDirectory = await getDatabasesPath();
    String path = join(documentDirectory, databaseName);
    return await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE FAMILY (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      familyname TEXT NOT NULL
      )
      ''');
    await db.execute('''CREATE TABLE MATERIEL (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nomMateriel TEXT NOT NULL,
      quantite INTEGER  NOT NULL,
      dateAcquisition INTEGER,
      dateRetour INTEGER,
      nomF TEXT NOT NULL,
      FOREIGN KEY(nomF) REFERENCES FAMILY(familyname)
      )
      ''');
    await db.execute(''' CREATE TABLE MEMBERS(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      firstName TEXT NOT NULL,
      lastName TEXT NOT NULL,
      phoneNumber INTEGER NOT NULL,
      quantite INTEGER NOT NULL,
      idMaterial INTEGER,
      state TEXT,
      dateReturn INTEGER,
      FOREIGN KEY(idMaterial) REFERENCES MATERIEL(id)
      )
    ''');
  }
}
