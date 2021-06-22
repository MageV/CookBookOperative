import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


abstract class BaseModel  {

  int id;
  static  fromMap(decode){}
  static toMap(){}
  static T fromJSON<T>(String str)
  {
    final decode=json.decode(str);
    return fromMap(decode) as T;
  }
  static String toJSON(){
    final encode=toMap();
    return json.encode(encode);
  }
}
