import 'package:mainapp/main.dart';
import 'package:mainapp/models/model.dart';
import 'package:mainapp/services/LocalizationService.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
import 'package:xml/xml.dart';

enum xmlResType { resType_GlossaryIngredient, resType_AppStrings }

class dbService {
  dbService._privateConstructor();
  late var Preferences;
  late DbDao DBdao;
  late SharedPreferences ApplicationParameters;

  static final dbService _instance = dbService._privateConstructor();
  factory dbService() {
    return _instance;
  }
  init(DbDao dao) async {
    DBdao = dao;
    ApplicationParameters = await SharedPreferences.getInstance();
    bool initialized = ApplicationParameters.getBool("INIT") ?? false;
    if (!initialized) {
      List<Category> items = [];
      for (int i = 1; i <= Categories; ++i) {
        String name = "cat_" + i.toString();
        String path = "assets/graphics/category/" + name + ".png";

        String? cat = LocalizationService().of(name);
        print(name);
        print(cat);
        items.add(new Category(i, cat!, path));
      }
      await dao.insertCategories(items);
      await ApplicationParameters.setBool("INIT", true);
      List<String> _raw = await parseXml(true);
      List<Ingredient> _ingredients = [];
      int id = 1;
      for (int i = 0; i < _raw!.length; i++) {
        Ingredient ingredient = new Ingredient(i, _raw[i]);
        int ids = await dao.insertIngredient(ingredient);
        print("ids:" + ids.toString());
      }
    }
  }

  static Future<List<String>> parseXml(bool fromFile) async {
    final List<String> output = [];
    Iterable<XmlElement> elements = [];
    if (fromFile) {
      output.clear();
      String filename = 'assets/data/ingredients_' + defaultLocale + '.xml';
      String xmlString = await rootBundle.loadString(filename);
      final document = XmlDocument.parse(xmlString);
      elements = document.findAllElements("row");
      elements.forEach((element) {
        output.add(element.text);
      });
    }
    return output;
  }

  static Future<Map<String, String>> parseAppXml(bool fromFile) async {
    Iterable<XmlElement> elements = [];
    final Map<String, String> output = new Map<String, String>();
    if (fromFile) {
      String filename = 'assets/data/appstring_' + defaultLocale + '.xml';
      String xmlString = await rootBundle.loadString(filename);
      final document = XmlDocument.parse(xmlString);
      elements = document.findAllElements("item");
      elements.forEach((element) =>
          output.putIfAbsent(element.name.toString(), () => element.text));
    }
    return output;
  }
}
