import 'package:flutter/material.dart';
import 'package:mainapp/main.dart';
import 'package:mainapp/models/model.dart';
import 'package:mainapp/services/localizationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dbService{
  dbService._privateConstructor();
  late var Preferences;
  late DbDao DBdao;
  late SharedPreferences ApplicationParameters;
  static final dbService _instance=dbService._privateConstructor();
  factory dbService()
  {
    return _instance;
  }
  init(DbDao dao)
  async {
    DBdao=dao;
    ApplicationParameters=await SharedPreferences.getInstance();
    bool initialized=ApplicationParameters.getBool("INIT")??false;
    if(!initialized) {
      List<Category> items=[];
      for (int i = 1; i <= Categories; ++i)
        {
          String name="cat_"+i.toString();
          String path="assets/graphics/category/"+name+".png";

          String? cat=localizationService().of(name);
          items.add(new Category(i,cat!, path));
        }
      await dao.insertCategories(items);
      await ApplicationParameters.setBool("INIT", true);
      }
  }

}