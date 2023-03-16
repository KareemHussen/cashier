import 'dart:convert';
import 'dart:io';

import 'package:cashier/data/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SQLHelper {
  static Future<Database> initDb() async {
    sqfliteFfiInit();
    final directory = await databaseFactoryFfi.getDatabasesPath();
    final path = join(directory, 'aa.db');
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    print(path + " ggggggggggggggggggggg");
    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
          version: 2,
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
      )
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
      )
  ''');
    debugPrint("table Created");
  }

  //add
  static Future<int> addProduct(
      String name, int quantity, int buyPrice, int sellPrice) async {
    final db = await SQLHelper.initDb(); //open database
    print(name);
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
      print("Something went wrong when : $err");
    }
  }

  //////////////////////////////////////////////////////////////////////////////

//add
  static Future<int> addInvoice(int price, List<Product> products) async {
    final db = await SQLHelper.initDb(); //open database
    final json = jsonEncode(products);

    final data = {
      'price': price,
      'products': json,
      'time': DateTime.now().millisecond
    }; //create data in map

    final id = await db.insert('invoices', data); //insert
    debugPrint("Data Added");
    return id;
  }

  static Future<List<Map<String, dynamic>>> getInvoices() async {
    final db = await SQLHelper.initDb();
    return db.query('invoices', orderBy: "id");
  }

  //get invoice by id
  static Future<List<Map<String, dynamic>>> getInvoice(int id) async {
    final db = await SQLHelper.initDb();
    return db.query('invoices', where: "id = ?", whereArgs: [id]);
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
      print("Something went wrong when : $err");
    }
  }
}
