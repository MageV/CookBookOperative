import 'package:mainapp/main.dart';
import 'package:mainapp/models/model.dart';
import 'package:mainapp/services/LocalizationService.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
import 'package:xml/xml.dart';

import 'ioService.dart';

class dbService {
  dbService._privateConstructor();
  late var Preferences;
  late DbDao DBdao;
  late SharedPreferences ApplicationParameters;

  static final dbService _instance = dbService._privateConstructor();
  factory dbService() {
    return _instance;
  }
  Future<void> Init(DbDao dao) async {
    DBdao = dao;
    ApplicationParameters = await SharedPreferences.getInstance();
    bool initialized = ApplicationParameters.getBool("INIT") ?? false;
    if (!initialized) {
      List<Category> items = [];
      for (int i = 1; i <= Categories; ++i) {
        String name = "cat_" + i.toString();
        String path = "assets/graphics/category/" + name + ".png";

        String? cat = LocalizationService().of(name);
        items.add(new Category(i, cat!, path));
      }
      await dao.insertCategories(items);
      await ApplicationParameters.setBool("INIT", true);
    }
  }
}
