import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mainapp/services/dbService.dart';
import 'package:mainapp/services/ioService.dart';
import 'package:mainapp/services/LocalizationService.dart';
import 'package:mainapp/views/CategoryView.dart';
import 'models/model.dart';

//Icons made by <a href="https://www.flaticon.com/authors/nhor-phai" title="Nhor Phai"

const int Categories=7;
late ioService IOService;
late LocalizationService LocaleService;
late dbService DBService;
late  Vision OCRApi;
final String defaultLocale=Platform.localeName;
late String modelTag;



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //print(defaultLocale);

  startMeUp() async
  {
    modelTag=(defaultLocale.split('_'))[0];
    IOService=ioService();
    LocaleService=LocalizationService();
    DBService=dbService();
    final databaseApplication=await $FloorAppDatabase.
    databaseBuilder("com.magev.cookbook.sqlite").build();
    await LocaleService.init(defaultLocale);
    await DBService.Init(databaseApplication.dbDao);
    OCRApi=(await IOService.getApi())!;
    runApp(CategoryView());
  }
   startMeUp();
}



