import 'dart:async';
import 'dart:ffi';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'model.g.dart';

@Entity(tableName: 'category')
class Category
{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String header;
  final String image_path;
  Category(this.id, this.header,this.image_path);
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
  final String ingredients;
  final String description;
  final String image_path;
  final int energy;
  final int fk_category;

  Recipe(this.id, this.header,this.ingredients,this.description,this.image_path,this.energy, this.fk_category);
}



@dao
abstract class DbDao
{
  @Query('select count(*) from category')
  Future<Int16?> getCategoryCount();

  @Query('SELECT * from category order by header')
  Future<List<Category?>> getAllCategories();

  @Query('Select id,header,image_path from Recipe where fk_category=:id order by header')
  Future<List<Recipe>?> getRecipeOfCategory(int id);

  @Query('select * from Recipe where id=:id')
  Future<List<Recipe>?> getRecipeById(int id);

  @Query("select id,header from Recipe where ingredients like '%:p1'")
  Future<Map<int,String>?> getRecipeByIngredients(String p1);


  @Query ('select max(id) from category')
  Future<int?> getLastIDCategory();

  @insert
  @OnConflictStrategy.replace
  Future<List<int>?> insertCategories(List<Category> items);
  @update
  Future<int?> UpdateCategories(List<Category> items);
  @insert
  Future<List<int>?> insertRecipes(List<Recipe> items);
  @update
  Future<int?> UpdateRecipes(List<Recipe> items);
  @delete
  Future<int?> deleteCategories(List<Category> items);
  @delete
  Future<int?> deleteRecipes(List<Recipe> items);
}

@Database(version:1,entities:[Category,Recipe])
abstract class AppDatabase extends FloorDatabase
{
  DbDao get dbDao;
}





