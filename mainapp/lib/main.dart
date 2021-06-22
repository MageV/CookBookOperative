import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mainapp/views/mainView.dart';
import 'package:mainapp/services/dbService.dart';


void main() {

   dbService dbservice;

  WidgetsFlutterBinding.ensureInitialized();
  startMeUp() async
  {
    await dbservice.init();
    runApp(MainView());
  }
  startMeUp();
}



