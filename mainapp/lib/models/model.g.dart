// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DbDao? _dbDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `header` TEXT NOT NULL, `image_path` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `recipe` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `header` TEXT NOT NULL, `ingredients` TEXT NOT NULL, `description` TEXT NOT NULL, `image_path` TEXT NOT NULL, `energy` INTEGER NOT NULL, `fk_category` INTEGER NOT NULL, FOREIGN KEY (`fk_category`) REFERENCES `category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DbDao get dbDao {
    return _dbDaoInstance ??= _$DbDao(database, changeListener);
  }
}

class _$DbDao extends DbDao {
  _$DbDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'image_path': item.image_path
                }),
        _recipeInsertionAdapter = InsertionAdapter(
            database,
            'recipe',
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'ingredients': item.ingredients,
                  'description': item.description,
                  'image_path': item.image_path,
                  'energy': item.energy,
                  'fk_category': item.fk_category
                }),
        _categoryUpdateAdapter = UpdateAdapter(
            database,
            'category',
            ['id'],
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'image_path': item.image_path
                }),
        _recipeUpdateAdapter = UpdateAdapter(
            database,
            'recipe',
            ['id'],
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'ingredients': item.ingredients,
                  'description': item.description,
                  'image_path': item.image_path,
                  'energy': item.energy,
                  'fk_category': item.fk_category
                }),
        _categoryDeletionAdapter = DeletionAdapter(
            database,
            'category',
            ['id'],
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'image_path': item.image_path
                }),
        _recipeDeletionAdapter = DeletionAdapter(
            database,
            'recipe',
            ['id'],
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'ingredients': item.ingredients,
                  'description': item.description,
                  'image_path': item.image_path,
                  'energy': item.energy,
                  'fk_category': item.fk_category
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final InsertionAdapter<Recipe> _recipeInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  final UpdateAdapter<Recipe> _recipeUpdateAdapter;

  final DeletionAdapter<Category> _categoryDeletionAdapter;

  final DeletionAdapter<Recipe> _recipeDeletionAdapter;

  @override
  Future<Int16?> getCategoryCount() async {
    await _queryAdapter.queryNoReturn('select count(*) from category');
  }

  @override
  Future<List<Category?>> getAllCategories() async {
    return _queryAdapter.queryList('SELECT * from category order by header',
        mapper: (Map<String, Object?> row) => Category(row['id'] as int,
            row['header'] as String, row['image_path'] as String));
  }

  @override
  Future<List<Recipe>?> getRecipeOfCategory(int id) async {
    return _queryAdapter.queryList(
        'Select id,header,image_path from Recipe where fk_category=?1 order by header',
        mapper: (Map<String, Object?> row) => Recipe(row['id'] as int, row['header'] as String, row['ingredients'] as String, row['description'] as String, row['image_path'] as String, row['energy'] as int, row['fk_category'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Recipe>?> getRecipeById(int id) async {
    return _queryAdapter.queryList('select * from Recipe where id=?1',
        mapper: (Map<String, Object?> row) => Recipe(
            row['id'] as int,
            row['header'] as String,
            row['ingredients'] as String,
            row['description'] as String,
            row['image_path'] as String,
            row['energy'] as int,
            row['fk_category'] as int),
        arguments: [id]);
  }

  @override
  Future<Map<int, String>?> getRecipeByIngredients(String p1) async {
    await _queryAdapter.queryNoReturn(
        'select id,header from Recipe where ingredients like \'%?1\'',
        arguments: [p1]);
  }

  @override
  Future<int?> getLastIDCategory() async {
    await _queryAdapter.queryNoReturn('select max(id) from category');
  }

  @override
  Future<List<int>> insertCategories(List<Category> items) {
    return _categoryInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertRecipes(List<Recipe> items) {
    return _recipeInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> UpdateCategories(List<Category> items) {
    return _categoryUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> UpdateRecipes(List<Recipe> items) {
    return _recipeUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCategories(List<Category> items) {
    return _categoryDeletionAdapter.deleteListAndReturnChangedRows(items);
  }

  @override
  Future<int> deleteRecipes(List<Recipe> items) {
    return _recipeDeletionAdapter.deleteListAndReturnChangedRows(items);
  }
}
