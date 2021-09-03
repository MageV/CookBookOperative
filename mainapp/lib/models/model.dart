import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'model.g.dart';

@Entity(tableName: "parameters")
class AppParameters
{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String value;
  AppParameters(this.id, this.name, this.value);
}


@Entity(tableName: 'category')
class Category
{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String header;
  final String image_path;
  Category(this.id, this.header,this.image_path);
}
@Entity(tableName: 'ingredient')
class Ingredient
{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String header;
  final String measure;
  final String image_path;
  Ingredient(this.id, this.header, this.measure,this.image_path);
}
@Entity(tableName: 'recipe',
foreignKeys: [
  ForeignKey(
      childColumns: ['fk_category'],
      parentColumns: ['id'],
      entity: Category)
])
class Recipe
{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String header;
  final String description;
  final String image_path;
  final int fk_category;

  Recipe(this.id, this.header, this.description,this.image_path, this.fk_category);
}
@Entity(tableName: 'contents',
foreignKeys: [
  ForeignKey(
    childColumns:['fk_recipe'],
    parentColumns:['id'],
    entity:Recipe
  ),
  ForeignKey(
    childColumns:['fk_ingrs'],
    parentColumns:['id'],
    entity:Ingredient
  )
])
class Contents {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final double volume;
  final int fk_recipe;
  final int fk_ingrs;
  Contents(this.id, this.volume, this.fk_recipe, this.fk_ingrs);
}



@dao
abstract class DbDao
{
  @Query('select value from parameters where name=:name')
  Future<List<String>?> getAppParameter(String name);
  @Query('select * from parameters')
  Future<List<AppParameters>> getAppParameters();
  @Query('select count(*) from category')
  Future<int?> getCategoryCount();
  @Query('SELECT * from Category order by header')
  Future<List<Category?>> getAllCategories();
  @Query('SELECT * from Ingredient order by header')
  Future<List<Ingredient>?> getAllIngredients();
  @Query('Select id,header,image_path from Recipe where fk_category=:id order by header')
  Future<List<Recipe>?> getRecipeOfCategory(int id);
  @Query('select id,header,description,image_path from Recipe where id=:id')
  Future<List<Recipe>?> getRecipeById(int id);
  @Query('select I.id,I.header,I.measure,C.volume'
      'from Ingredient inner join on I.id=c.fk_ingrs where C.fk_recipe=:recid')
  Future<List<dynamic>?> selectDetailedRecipe(int recid);

  @insert
  Future<List<int>?> insertAppParameters(List<AppParameters> items);
  @update
  Future<int?> UpdateAppParameters(List<AppParameters> items);
  @delete
  Future<int?> deleteAppParameters(List<AppParameters> items);
  @insert
  Future<List<int>?> insertCategories(List<Category> items);
  @update
  Future<int?> UpdateCategories(List<Category> items);
  @insert
  Future<List<int>?> insertIngredients(List<Ingredient> items);
  @update
  Future<int?> UpdateIngredients(List<Ingredient> items);
  @insert
  Future<List<int>?> insertRecipes(List<Recipe> items);
  @update
  Future<int?> UpdateRecipes(List<Recipe> items);
  @insert
  Future<List<int>?> insertContents(List<Contents> items);
  @update
  Future<int?> UpdateContents(List<Contents> items);
  @delete
  Future<int?> deleteCategories(List<Category> items);
  @delete
  Future<int?> deleteIngredients(List<Ingredient> items);
  @delete
  Future<int?> deleteRecipes(List<Recipe> items);
  @delete
  Future<int?> deleteContents(List<Contents> items);
}

@Database(version:1,entities:[Category,Ingredient,Recipe,Contents,AppParameters])
abstract class AppDatabase extends FloorDatabase
{
  DbDao get dbDao;
}





