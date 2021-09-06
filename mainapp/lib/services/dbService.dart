import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:mainapp/main.dart';
import 'package:mainapp/models/model.dart';
import 'package:mainapp/services/localizationService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';


class dbService{
  dbService._privateConstructor();
  late var Preferences;
  late DbDao DBdao;
  late SharedPreferences ApplicationParameters;
  static final dbService _instance=dbService._privateConstructor();
  factory dbService()
  {
    return _instance;
  }
  init(DbDao dao)
  async {
    DBdao=dao;
    ApplicationParameters=await SharedPreferences.getInstance();
    bool initialized=ApplicationParameters.getBool("INIT")??false;
    if(!initialized) {
      List<Category> items=[];
      for (int i = 1; i <= Categories; ++i)
        {
          String name="cat_"+i.toString();
          String path="assets/graphics/category/"+name+".png";

          String? cat=LocalizationService().of(name);
          print(name);
          print(cat);
          items.add(new Category(i,cat!, path));
        }
      int? ing_count=await dao.getIngredientsCount();
      if(ing_count==0) {
        List<dynamic> _raw = await _parseCSV(true);
        List<Ingredient> _ingredients = [];
        int id = 0;
        _raw.forEach((element) {
          if (element
              .toString()
              .length > 1) {
            Ingredient ingredient = new Ingredient(id, element.toString());
            ++id;
            _ingredients.add(ingredient);
          }
        });
        if (_ingredients.isNotEmpty) {
          await dao.insertIngredients(_ingredients);
        }
      }
      await dao.insertCategories(items);
      await ApplicationParameters.setBool("INIT", true);
      }
  }
  Future<List<dynamic>>_parseCSV(bool fromFile)
  async {
  List<dynamic> returnValue=[];
    if(fromFile) {
      final input = new File('assets/data/ingredients_rus.csv').openRead();
      returnValue=(await input.transform(utf8.decoder)).transform(
       new CsvToListConverter()) as List ;
    }
    return returnValue;
  }

}