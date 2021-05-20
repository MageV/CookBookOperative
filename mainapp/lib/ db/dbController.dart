import 'package:flutter/material.dart';
import 'package:mainapp/models/BaseModel.dart';
import 'package:mainapp/models/NewsItem.dart';
import 'package:sqflite/sqflite.dart';


 class dbController {

  dbController._();

  static final dbController db=dbController._();
  static Database _database;
  var tableCreate=[NewsItem.createQuery];
  int get _version => 1;

  Future<Database> get database async
  {
    if(_database==null)
      {
        _database=await init();
      }
    return _database;
  }


  init() async {

      String _path = await getDatabasesPath() + 'opcook';
      return await openDatabase(
          _path,
          version: _version,
          onOpen: (db){},
          onCreate:(Database db, int version)
          async{
            await tableCreate.forEach((element) {db.execute(element);});
          }
      );
  }


  Future<int> insert(String table, BaseModel model) async =>
      await _database.insert(table, BaseModel.toMap());

  Future<int> update(String table, BaseModel model) async =>
      await _database.update(table, BaseModel.toMap(), where: 'id = ?', whereArgs: [model.id]);

  Future<int> delete(String table, BaseModel model) async =>
      await _database.delete(table, where: 'id = ?', whereArgs: [model.id]);

   Future<List<Map<String, dynamic>>> queryAll(String table) async => _database.query(table);
   Future<List<Map<String, dynamic>>> queryById(String table,int id)
   async
   {
     //final db=await _database;
     var result=await _database.query(table,where: "id=",whereArgs: [id]);
     return result;
   }
  Future<List<Map<String, dynamic>>> queryByHeader(String table,String header)
  async {
    var result=await _database.query(table,where: "header=",whereArgs: [header]);
    return result;
  }
 }
