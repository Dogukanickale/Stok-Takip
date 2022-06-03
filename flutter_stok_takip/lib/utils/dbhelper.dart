import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_stok_takip/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  final String _productTable = "product";
  final String _columnID = "id"; //Uygulama boyunca değiştiremez değerler
  final String _columnName = "name";
  final String _columnStok = 'stok';

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "product2.db");
    var productsDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return productsDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table $_productTable($_columnID integer primary key, $_columnName text, $_columnStok int)");
  }

  Future<List<Product>> getAllProduct() async {
    Database? db = await database;
    var result = await db!.query(_productTable);
    return List.generate(result.length, (i) {
      return Product.fromMap(result[i]);
    });
  }

  Future<int> insert(Product product) async {
    Database? db = await database;
    var result = await db!.insert(_productTable, product.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database? db = await database;
    var result = await db!.rawDelete("delete from $_productTable where id=$id");
    //var result = await db!.delete("product", where: "id=?", whereArgs: [id]);
    return result;
  }

  Future<void> productIncrementStatus(Product product, bool stokStatus) async {
    Database? db = await database;
    if (stokStatus) {
      if (product.stok != null) {
        product.stok = (product.stok! + 1);
      }
    } else {
      if (product.stok != null && product.stok! > 0) {
        product.stok = (product.stok! - 1);
      }
    }
    var result = await db!.update(_productTable, product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    debugPrint(result.toString());
  }

  Future<int> update(Product product) async {
    Database? db = await database;
    var result = await db!.update(_productTable, product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
