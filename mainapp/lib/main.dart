import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mainapp/services/dbService.dart';
import 'package:mainapp/services/ioService.dart';
import 'package:mainapp/services/LocalizationService.dart';
import 'package:mainapp/views/CategoryView.dart';
import 'models/model.dart';



const int Categories=7;
late var IOService;
late var LocaleService;
late var DBService;
final String defaultLocale=Platform.localeName;



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //print(defaultLocale);

  startMeUp() async
  {
    IOService=ioService();
    LocaleService=LocalizationService();
    DBService=dbService();
    final databaseApplication=await $FloorAppDatabase.
    databaseBuilder("com.magev.cookbook.sqlite").build();
    await LocaleService.init(defaultLocale);
    await DBService.Init(databaseApplication.dbDao);
    runApp(CategoryView());
  }
   startMeUp();
}



