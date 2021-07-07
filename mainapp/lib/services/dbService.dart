import 'package:flutter/material.dart';
import 'package:mainapp/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dbService{
  dbService._privateConstructor();
  late var Preferences;
  late DbDao DBdao;
  late var ApplicationParameters;
  static final dbService _instance=dbService._privateConstructor();
  factory dbService()
  {
    return _instance;
  }
  init(DbDao dao)
  async {
    DBdao=dao;
    Preferences=await SharedPreferences.getInstance();
  }

}