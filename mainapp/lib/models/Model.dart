
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
class Model
{
  static const tableIngredients=SqfEntityTable(
    tableName: 'ingredients',
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
  static const tableCategory=SqfEntityTable(
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
  static const tableRecipes=SqfEntityTable(
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
static const tableContents=SqfEntityTable(
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
static const viewCategoryRecipe=SqfEntityTable(
  modelName: null,
  tableName: 'viewcatrecipe',
  objectType: ObjectType.view,

);
}
