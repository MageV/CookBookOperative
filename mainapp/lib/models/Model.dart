
import 'package:sqfentity_gen/sqfentity_gen.dart';

class Model
{
  static final tableIngredients=SqfEntityTable(tableName: 'ingredients',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields:
      [
        SqfEntityField('header', DbType.text),
        SqfEntityField('measure',DbType.text),
      ]
  );
  static final tableCategory=SqfEntityTable(
    tableName: 'category',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields:
      [
        SqfEntityField('header',DbType.text),
        SqfEntityField('imagepath',DbType.text)
      ]
  );
  static final tableRecipes=SqfEntityTable(
    tableName:'recipes',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('header',DbType.text),
      SqfEntityField('description', DbType.text),
      SqfEntityField('imagepath', DbType.text),
      SqfEntityFieldRelationship(
        parentTable: tableCategory,
        deleteRule: DeleteRule.CASCADE,
        fieldName: 'fk_category',
        defaultValue: 0)
    ]
  );
static final tableContents=SqfEntityTable(
  tableName: 'contents',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  primaryKeyName: 'id',
  useSoftDeleting: true,
  modelName: null,
  fields:[
    SqfEntityField('volume', DbType.real),
    SqfEntityFieldRelationship(
      parentTable: tableRecipes,
      deleteRule: DeleteRule.CASCADE,
      fieldName: 'fk_recipe',
      defaultValue: 0
    ),
    SqfEntityFieldRelationship(
      parentTable: tableIngredients,
      deleteRule: DeleteRule.CASCADE,
      fieldName: 'fk_ingrs',
      defaultValue: 0
    ),
  ]
);
static final viewCategoryRecipe=SqfEntityTable(
  modelName: null,
  tableName: 'viewcatrecipe',
  objectType: ObjectType.view,
  fields: [
    SqfEntityField('category_name', DbType.text),
    SqfEntityField('recipe', DbType.text),
    SqfEntityField('recipe_id', DbType.integer),
    SqfEntityFieldRelationship(
      parentTable: tableCategory,
      deleteRule: DeleteRule.NO_ACTION,
      fieldName: 'catid',
      isPrimaryKeyField: false
    ),
  ],
  sqlStatement: 'SELECT '
      'catid,'
      'category.header as category_name'
      'recipes.id as recipe_id,'
      'recipes.header as recipe'
      'from category'
      'inner join recipes on category.id=recipes.fk_category'
      'order by catid'
);
static final dbModel=SqfEntityModel(
  databaseName: 'cookbook',
  password: null,
  databaseTables: [tableCategory,tableIngredients,tableRecipes,tableContents],
  formTables: [tableCategory,tableIngredients,tableRecipes],
  bundledDatabasePath: '/assets/com.magev.cookbook.sqlite'
);
}
