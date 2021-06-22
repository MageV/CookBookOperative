import 'dart:convert';

import 'package:mainapp/models/BaseModel.dart';

class RecipesItem extends BaseModel
{
  static String tablename="recipes";
  static String createQuery="CREATE TABLE $tablename("
      "ID INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT,"
      "HEADER TEXT,"
      "DATA TEXT,"
      "FILEPATH TEXT";

  int id;
  String header;
  String data;
  String filepath;
  int fkcontent;

  RecipesItem({this.id, this.header, this.data, this.filepath, this.fkcontent});

  Map<String,dynamic> toMap()
  {
    Map<String,dynamic> map=
    {
      "header":header,
      "data":data,
      "filepath":filepath,
      "fkcontent":fkcontent
    };
    if(id!=null){map['id']=id;}
    return map;
  }
  RecipesItem fromMap(Map<String,dynamic> map)
  {
    return
     RecipesItem(id: map["id"],
          header: map["header"],
          data: map["data"],
          filepath: map["filepath"],
          fkcontent:map["fkcontent"]);
  }
}