import 'dart:io';
import 'package:new_tablet/models/base_model.dart';
import 'package:new_tablet/models/item_model.dart';
import 'package:new_tablet/models/user_configs_model.dart';
import 'package:new_tablet/utils/utils.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;
  String tableName = '';
  Map<dynamic, dynamic> columns = Map<dynamic, dynamic>();
  List<dynamic> fields = [];

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }


  DatabaseHelper.internal();

  // create database
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path =
        join(documentDirectory.path, "${utils.account}_${utils.username}.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  // create tables
  void _onCreate(Database db, int version) async {
    await db.execute(createTable(tableName, columns));
  }

  String getType(Type type) {
    if (type is int) {
      return 'INTEGER';
    } else if (type is String) {
      return 'TEXT';
    } else if (type is double) {
      return '';
    } else {
      return 'TEXT';
    }
  }

  String createColumns(map) {
    String columns = '';
    map.forEach((key) {
      if (key.toLowerCase() == 'code') {
        columns += '$key TEXT PRIMARY KEY NOT NULL, ';
      } else {
        columns += '${key.replaceAll(".", "_")} TEXT, ';
      }
    });

    return columns.endsWith(', ')
        ? columns.substring(0, columns.length - 2)
        : columns;
  }

  String createTable(String tableName, map) {
    String columns = createColumns(fields);
    String table = 'CREATE TABLE IF NOT EXISTS $tableName ($columns)';
    print('table $table');
    return table;
  }

  //drop table
  dropTable() async {
    var dbClient = await db;
    // dbClient.delete(tableName);
    dbClient.execute('DROP TABLE IF EXISTS $tableName');
    await dbClient.execute(createTable(tableName, columns));
  }

  // insert user to db when loginf
  Future<int> saveTableData(List<dynamic> list) async {
    // Database dbClient = await db;
    // list.forEach((element) async {
    //   await dbClient.insert(tableName, element);
    // });
    // return 1;

    Batch batch = (await db).batch();

    for (int i = 0; i < list.length; i++) {
      batch.insert(tableName, list[i]);
    }
    await batch.commit(noResult: true);
    return 1;
  }

  // retrieve user from db
  Future<List<dynamic>> getTableData() async {
    var dbClient = await db;
    // List<Map> list = [];
    // print(DateTime.now().millisecondsSinceEpoch);
    // list = await dbClient.rawQuery('SELECT * FROM $tableName');
    // print(DateTime.now().millisecondsSinceEpoch);
    // // print(list);
    // // if (list.isNotEmpty) {
    // //   return list.elementAt(0);
    // // }
    // return list;

    return await dbClient.transaction((txn) async {
      var batch = txn.batch();
      List<Map> list = [];
      print(DateTime.now().millisecondsSinceEpoch);
      list = await txn.rawQuery('SELECT * FROM $tableName');
      print(DateTime.now().millisecondsSinceEpoch);
      // print(list);
      // if (list.isNotEmpty) {
      //   return list.elementAt(0);
      // }
      await batch.commit(noResult: true);
      return list;
    });
  }

  // Future<AppResult<int>> save(Order order) async {
  //   Database db;
  //   var dbReturn = BaseService();
  //   try {
  //     db = await databaseOpen();
  //     int dbSaveResult = 0;
  //     await db.transaction((txn) async {
  //       var batch = txn.batch();
  //       final List<Map<String, dynamic>> exist = await db.query(tableName, where: "id =?", whereArgs: [order.id]);
  //       if (exist.length == 0) {
  //         await _insert(order, txn, batch);
  //       } else {
  //         await _update(order, txn, batch);
  //       }
  //       await batch.commit(continueOnError: true).then((value) {
  //         if (value.length > 0) dbSaveResult = value.length;
  //       });
  //     });
  //     return dbReturn.success<int>(dbSaveResult, "Kaydedildi", 1, 1);
  //   } on Exception catch (e) {
  //     return dbReturn.failed<int>(-1, "OrderDbService -> save", 0, 0, e);
  //   } finally {
  //     if (db != null && db.isOpen) {
  //       await db.close();
  //     }
  //   }
  // }

  Future<void> insertRows(List<dynamic> list) async {
    try {
      Database dbClient = await db;
      List<String> questionMarks = List<String>.filled(fields.length, '?');

      String query =
          'INSERT INTO $tableName (${fields.map((e) => e.replaceAll(".", "_")).join(',')}) VALUES(${questionMarks.join(',')})';
      List<String> insertedList = [];

      await dbClient.rawInsert(query, list);
    } catch (e) {
      print(e);
    }
  }

  T unmarshal<T>(json, {Type? type}) {
    type ??= T;

    switch (type) {
      case ItemModel:
      // return ItemModel.toJson(json) as T;
      default:
        throw StateError('Unable to unmarshal value of type \'$type\'');
    }
  }

  // //delete use when logout
  // Future<int> deleteUser() async {
  //   var dbClient = await db;
  //   int res = await dbClient.delete("User");
  //   return res;
  // }

  // // check if the user logged in when app launch or any other place
  // Future<bool> isLoggedIn() async {
  //   var dbClient = await db;
  //   var res = await dbClient.query("User");
  //   return res.length > 0 ? true : false;
  // }
}
