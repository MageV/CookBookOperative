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

  
}