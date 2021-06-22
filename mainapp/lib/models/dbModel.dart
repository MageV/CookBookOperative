import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'view.list.dart';

class Model
{
  static const  tableIngredients=SqfEntityTable(
    tableName: 'ingredients',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('header', DbType.text),
      SqfEntityField('measure',DbType.text)
    ]
  );

  static const tableRecipes=SqfEntityTable(
    tableName: 'recipes',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('header',DbType.text),
      SqfEntityField('image', DbType.blob),
      SqfEntityField('description', DbType.text),
      SqfEntityField('recdate', DbType.datetime)
    ]
  );

  static const tableContents=SqfEntityTable(
    tableName: "contents",
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    primaryKeyName: "id",
    useSoftDeleting: true,
    fields: [
      SqfEntityField("volume", DbType.real),
      SqfEntityFieldRelationship(
        parentTable:tableIngredients,
        deleteRule: DeleteRule.CASCADE,
        fieldName: 'id',
        isPrimaryKeyField: false
      ),
      SqfEntityFieldRelationship(
        parentTable: tableRecipes,
        deleteRule: DeleteRule.CASCADE,
        fieldName: 'id',
        isPrimaryKeyField: false
      )
    ]
  );
  
}