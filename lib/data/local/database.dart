import 'dart:convert';

import 'package:cashier/data/model/Product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SQLHelper {
  static Future<Database> initDb() async {
    sqfliteFfiInit();
    final directory = await databaseFactoryFfi.getDatabasesPath();
    final path = join(directory, 'cashier.db');
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    if (kDebugMode) {
      print(path + " ggggggggggggggggggggg");
    }
    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
          version: 1,
          onCreate: (Database database, int version) async {
            await createTableproducts(database);
            await createTableinvoices(database);
          }),
    );
  }

  static Future<void> createTableproducts(Database database) async {
    await database.execute('''
    CREATE TABLE products (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      quantity INTEGER NOT NULL,
      buyPrice INTEGER NOT NULL,
      sellPrice INTEGER NOT NULL
      );
  ''');
    debugPrint("table Created");
  }

  static Future<void> createTableinvoices(Database database) async {
    await database.execute('''
    CREATE TABLE invoices (
      id INTEGER PRIMARY KEY,
      price INTEGER NOT NULL,
      products TEXT NOT NULL,
      time INTEGER NOT NULL,
      gain INTEGER NOT NULL,
      date TEXT NOT NULL,
      hour TEXT NOT NULL
      );
  ''');
    debugPrint("table Created");
  }

  //add
  static Future<int> addProduct(
      String name, int quantity, int buyPrice, int sellPrice) async {
    final db = await SQLHelper.initDb(); //open database
    if (kDebugMode) {
      print(name);
    }
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
      int id, String name, int quantity, int buyPrice, int sellPrice) async {
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
      if (kDebugMode) {
        print("Something went wrong when : $err");
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////

//add
  static Future<int> addInvoice(int price, List<Product> products , int gain ) async {
    final db = await SQLHelper.initDb(); //open database
    final json = jsonEncode(products);

    var currentTime = DateTime.now().millisecondsSinceEpoch;

    var dt = DateTime.fromMillisecondsSinceEpoch(currentTime);

    var d12 = DateFormat('MM/dd/yyyy, hh:mm:ss a').format(dt);

    var date = d12.substring(0 , 10);
    var hour = d12.substring(12 , 23);

    final data = {
      'price': price,
      'products': json,
      'time': currentTime,
      'gain' : gain,
      'date' : date,
      'hour' : hour
    }; //create data in map

    final id = await db.insert('invoices', data); //insert
    debugPrint("Data Added");
    return id;
  }

  static Future<List<Map<String, dynamic>>> getInvoices() async {
    final db = await SQLHelper.initDb();
    return db.query('invoices', orderBy: "time DESC");
  }

  //get invoice by id
  static Future<List<Map<String, dynamic>>> getInvoice(int id) async {
    final db = await SQLHelper.initDb();
    return db.query('invoices', where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getInvoicesByTime(int startTimestamp, int endTimestamp) async {
    final db = await SQLHelper.initDb();
    List<Map<String, dynamic>> list = await db.rawQuery(
      'SELECT * FROM invoices WHERE time BETWEEN ? AND ? ORDER BY time DESC',
      [startTimestamp, endTimestamp],
    );    return list;
  }

  //get invoice by time
  static Future<List<Map<String, dynamic>>> getInvoiceByTime(DateTime id) async {
    final db = await SQLHelper.initDb();
    return db.query('invoices', where: "time >= ?", whereArgs: [id.millisecond]);
  }

  //update
  static Future<int> updateInvoice(
      int id, int price, List<Product> products) async {
    final db = await SQLHelper.initDb();
    final data = {
      'price': price,
      'products': products.toString(),
    }; //create data

    final result =
        await db.update('invoices', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteInvoice(int id) async {
    final db = await SQLHelper.initDb();
    try {
      await db.delete("invoices", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      if (kDebugMode) {
        print("Something went wrong when : $err");
      }
    }
  }
}
