import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mainapp/models/BaseModel.dart';


class NewsItem extends BaseModel
{
  static String tableName="news";
  static String createQuery="CREATE TABLE NEWS("
  "ID INTEGER PRIMARY KEY NOT NULL,"
  "DATENEWS STRING,"
  "HEADER STRING"
  "CONTENT STRING"
  "STATUS STRING)";

  String dateNews;
  String header;
  String content;
  String status;
  int id;


  NewsItem({this.id,this.dateNews,this.header,this.status,this.content});

  Map<String,dynamic> toMap()
  {
    Map<String,dynamic> map =
        {
          'dateNews':dateNews,
          'header':header,
          'content':content,
          'status':status
        };
    if(id!=null){map['id']=id;}
    return map;
  }
   NewsItem fromMap(Map<String,dynamic> map)
  {
    return NewsItem(
      id:map['id'],
      dateNews: map['dateNews'],
      header: map['header'],
      content: map['content'],
      status:map['status']
    );
  }
   NewsItem fromJSON(String str)
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