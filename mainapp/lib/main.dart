import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mainapp/mainView.dart';
import 'package:path_provider/path_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  startMeUp() async
  {
    Directory docsDir=await
        getApplicationDocumentsDirectory();
    runApp(MainView());
  }
  startMeUp();
}



