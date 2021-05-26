import 'dart:convert';
import 'dart:ffi';

import 'package:mainapp/models/BaseModel.dart';

class ContentItem extends BaseModel
{
  static String tableName="content";
  static String createQuery="CREATE TABLE $tableName"
      "ID INTEGER PRIMARY KEY NOT NULL,"
      "HEADER TEXT,"
      "COUNT REAL,"
      "MEASURE TEXT,"
      "FKINGREDIENTS INT"
      "FOREIGN KEY(FK_INGREDIENTS) REFERENCES INGREDIENTS(ID)";
  int id;
  String header;
  int fkingredients;
  Double count;
  String measure;

  ContentItem({this.id,this.header,this.fkingredients,this.count,this.measure});

  Map<String,dynamic> toMap()
  {
    Map<String,dynamic> map=
    {
      "header":header,
      "count":count,
      "measure":measure,
      "fkingredients":fkingredients
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
      fkingredients: map["fkingredients"]);
  }

  ContentItem fromJSON(String str)
  {
    final decode=json.decode(str);
    return fromMap(decode);
  }
  String toJSON()
  {
    final encode=toMap();
    return json.encode(encode);
  }
}