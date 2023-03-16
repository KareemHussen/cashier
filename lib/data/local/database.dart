import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<Database> initDb() async {
    return sql.openDatabase(
      'products.db', //database name
      version: 1, //version number
      onCreate: (Database database, int version) async {
        await createTableproducts(database);
      },
    );
  }
//String name;
//   int quantity;
//   int buyPrice;
//   int sellPrice;
//   int id;
  static Future<void> createTableproducts(Database database) async {
    await database.execute("""CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        buyPrice INTEGER,
        sellPrice INTEGER,
        quantity INTEGER,        
      )
      """);

    debugPrint("table Created");
  }

  //add
  static Future<int> addProduct(
      String name, int quantity,int buyPrice , int sellPrice) async {
    final db = await SQLHelper.initDb(); //open database
    final data = {
      'name': name,
      'quantity': quantity,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,

    }; //create data in map
    final id = await db.insert('products', data); //insert
    debugPrint("Data Added");
    return id;
  }

//read all products
  static Future<List<Map<String, dynamic>>> getproducts() async {
    final db = await SQLHelper.initDb();
    return db.query('products', orderBy: "id");
  }

  //get plant by id
  static Future<List<Map<String, dynamic>>> getProduct(int id) async {
    final db = await SQLHelper.initDb();
    return db.query('products', where: "id = ?", whereArgs: [id]);
  }

  //update
  static Future<int> updateProduct(
      int id,String name, int quantity,int buyPrice , int sellPrice) async {
    final db = await SQLHelper.initDb();
    final data = {
      'name': name,
      'quantity': quantity,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,

    }; //create data

    final result =
        await db.update('products', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteProduct(int id) async {
    final db = await SQLHelper.initDb();
    try {
      await db.delete("products", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when : $err");
    }
  }
}
