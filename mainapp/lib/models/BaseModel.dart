import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


abstract class BaseModel  {

  int id;
  static fromMap(){}
  static toMap(){}
  static fromJSON(){}
  static toJSON(){}
}
