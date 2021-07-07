import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mainapp/services/dbService.dart';
import 'package:mainapp/services/localizationService.dart';
import 'package:mainapp/views/mainView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/model.dart';

var LocaleService=localizationService();
var DBService=dbService();



void main() {
  final String defaultLocale=Platform.localeName;
  WidgetsFlutterBinding.ensureInitialized();
  startMeUp() async
  {
    final DatabaseApplication=await $FloorAppDatabase.databaseBuilder('com.magev.cookbook.sqlite').build();
    switch(defaultLocale)
    {
      case "en_US":
        {
          LocaleService.init(defaultLocale);
          break;
        }
      case "ru_RU":
        {
          LocaleService.init(defaultLocale);
        }
    }
    DBService.init(DatabaseApplication.dbDao);
    runApp(MainView());
  }
  startMeUp();
}



