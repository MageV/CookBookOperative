import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mainapp/services/dbService.dart';
import 'package:mainapp/services/LocalizationService.dart';
import 'package:mainapp/views/CategoryView.dart';
import 'models/model.dart';


const int Categories=7;
var LocaleService=LocalizationService();
var DBService=dbService();
final String defaultLocale=Platform.localeName;



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //print(defaultLocale);
  startMeUp() async
  {

    final databaseApplication=await $FloorAppDatabase.
    databaseBuilder("com.magev.cookbook.sqlite").build();
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
    DBService.init(databaseApplication.dbDao);
    runApp(CategoryView());
  }
  startMeUp();
}



