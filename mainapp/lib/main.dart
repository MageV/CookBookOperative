import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mainapp/services/dbService.dart';
import 'package:mainapp/views/mainView.dart';
import 'models/model.dart';



void main() {


  WidgetsFlutterBinding.ensureInitialized();
  startMeUp() async
  {
    final DatabaseApplication=await $FloorAppDatabase.databaseBuilder('com.magev.cookbook.sqlite').build();
    dbService service=dbService();
    service.init(DatabaseApplication.dbDao);
    runApp(MainView());
  }
  startMeUp();
}



