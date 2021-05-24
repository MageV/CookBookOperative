import 'package:mainapp/models/BaseModel.dart';

class IngridientsItem extends BaseModel
{
  static String tableName="news";
  int id;
  String header;
  int calories;
  static String createQuery="CREATE TABLE INGRIDIENTS("
      "ID INTEGER PRIMARY KEY NOT NULL, "
      "HEADER STRING,"
      "CALORIES INTEGER)";
  
}