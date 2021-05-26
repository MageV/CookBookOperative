import 'dart:convert';

import 'package:mainapp/models/BaseModel.dart';

class IngredientsItem extends BaseModel
{
  static String tableName="ingredients";
  int id;
  String header;
  String filelink;
  int calories;
  static String createQuery="CREATE TABLE $tableName("
      "ID INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT,"
      "HEADER TEXT,"
      "FILE_LINK TEXT,"
      "CALORIES INTEGER)";

  IngredientsItem({this.id,this.header,this.filelink,this.calories});

  Map<String,dynamic> toMap()
  {
    Map<String,dynamic> map=
        {
          "header":header,
          "filelink":filelink,
          "calories":calories
        };
    if(id!=null){map['id']=id;}
    return map;
  }
  IngredientsItem fromMap(Map<String,dynamic> map)
  {
    return
        IngredientsItem(id: map["id"],
            header: map["header"],
            filelink: map["filelink"],
            calories: map["calories"]);
  }

  IngredientsItem fromJSON(String str)
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