import 'dart:io';
import 'package:db_miner/modal/quotes_modal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Database_helper {
  static Database_helper database = Database_helper();

  final String database_name = 'quotes.db';
  String quotes_tablename = 'quotestable';
  String category_tablename = 'categorytable';
  Database? db;

  Future<Database?> checkdb() async {
    if (db != null) {
      return db;
    } else {
      return await initdb();
    }
  }

  Future<Database> initdb() async {
    Directory file = await getApplicationDocumentsDirectory();
    String path = join(file.path, database_name);
    return db = await openDatabase(path, onCreate: (db, version) async {
      String quotes =
          "CREATE TABLE $quotes_tablename (id INTEGER PRIMARY KEY AUTOINCREMENT,quote TEXT,category TEXT,author TEXT,like INTEGER)";
      String category =
          "CREATE TABLE $category_tablename (id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT)";
      await db.execute(quotes);
      await db.execute(category);
    }, version: 1);
  }

  Future<void> insert(Quotesmodal q) async {
    db = await checkdb();
    await db!.insert("${quotes_tablename}", {
      "quote": q.quote,
      "category": q.category,
      "author": q.author,
    });
  }


  Future<List<Map>> readdb() async {
    db = await checkdb();
    String query = 'SELECT * FROM $quotes_tablename';
    List<Map> quotes = await db!.rawQuery(query);
    return quotes;
  }

  Future<void> update(Quotesmodal q) async {
    db = await checkdb();
    await db!.update("${quotes_tablename}", {
      "quote": q.quote,
      "category": q.category,
      "author": q.author,
      "like":q.like
    },where: "id=?",whereArgs: [q.id],);
  }

  Future<List<Map>> filterdata(String name) async {
    db = await checkdb();
    String query = 'SELECT * FROM $quotes_tablename WHERE category="$name"';
    List<Map> list = await db!.rawQuery(query);
    print("${list.length}=========");
    print("${list}=========");
    return list;
  }
//=====================================CATEGORY DATA===================
  Future<void> category_insert(String category) async {
    db = await checkdb();
    await db!.insert(category_tablename, {"category": category});
  }

  Future<List<Map>> category_readdb() async {
    db = await checkdb();
    String sql = 'SELECT * FROM $category_tablename';
    List<Map> category = await db!.rawQuery(sql);
    return category;
  }


  Future<void> deletedb(int id) async {
    db = await checkdb();
    db!.delete(category_tablename, where: 'id=?', whereArgs: [id]);
  }
}
