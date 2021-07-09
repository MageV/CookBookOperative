import 'package:flutter/material.dart';
import 'package:mainapp/models/model.dart';
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
    if(!initialized)
      {

      }
  }

}