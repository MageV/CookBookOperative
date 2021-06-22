import 'dart:convert';
import 'dart:ffi';

import 'package:mainapp/models/BaseModel.dart';

class ContentItem extends BaseModel
{
  static String tableName="content";
  static String createQuery="CREATE TABLE $tableName"
      "ID INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT,"
      "HEADER TEXT,"
      "COUNT REAL,"
      "MEASURE TEXT,"
      "FKINGREDIENTS INT,"
      "FKRECIPE INT"
      "FOREIGN KEY(FKINGREDIENTS) REFERENCES INGREDIENTS(ID),"
      "FOREIGN KEY(FKRECIPE) REFERENCES RECIPES(ID))";
  int id;
  String header;
  int fkingredients;
  int fkrecipe;
  Double count;
  String measure;

  ContentItem({this.id,this.header,this.fkingredients,this.fkrecipe,
    this.count,this.measure});

  Map<String,dynamic> toMap()
  {
    Map<String,dynamic> map=
    {
      "header":header,
      "count":count,
      "measure":measure,
      "fkingredients":fkingredients,
      "fkrecipe":fkrecipe
    };
    if(id!=null){map['id']=id;}
    return map;
  }
  ContentItem fromMap(Map<String,dynamic> map)
  {
    return
      ContentItem(id: map["id"],
          header: map["header"],
          count: map["count"],
        measure: "measure",
        fkingredients: map["fkingredients"],
        fkrecipe : map["fkrecipe"]);

  }

}