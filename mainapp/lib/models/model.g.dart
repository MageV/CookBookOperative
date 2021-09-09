// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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
            'CREATE TABLE IF NOT EXISTS `ingredient` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `header` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `recipe` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `header` TEXT NOT NULL, `description` TEXT NOT NULL, `image_path` TEXT NOT NULL, `fk_category` INTEGER NOT NULL, FOREIGN KEY (`fk_category`) REFERENCES `category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `contents` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `volume` REAL NOT NULL, `measure` TEXT NOT NULL, `fk_recipe` INTEGER NOT NULL, `fk_ingrs` INTEGER NOT NULL, FOREIGN KEY (`fk_recipe`) REFERENCES `recipe` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`fk_ingrs`) REFERENCES `ingredient` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

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
        _ingredientInsertionAdapter = InsertionAdapter(
            database,
            'ingredient',
            (Ingredient item) =>
                <String, Object?>{'id': item.id, 'header': item.header}),
        _recipeInsertionAdapter = InsertionAdapter(
            database,
            'recipe',
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'description': item.description,
                  'image_path': item.image_path,
                  'fk_category': item.fk_category
                }),
        _contentsInsertionAdapter = InsertionAdapter(
            database,
            'contents',
            (Contents item) => <String, Object?>{
                  'id': item.id,
                  'volume': item.volume,
                  'measure': item.measure,
                  'fk_recipe': item.fk_recipe,
                  'fk_ingrs': item.fk_ingrs
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
        _ingredientUpdateAdapter = UpdateAdapter(
            database,
            'ingredient',
            ['id'],
            (Ingredient item) =>
                <String, Object?>{'id': item.id, 'header': item.header}),
        _recipeUpdateAdapter = UpdateAdapter(
            database,
            'recipe',
            ['id'],
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'description': item.description,
                  'image_path': item.image_path,
                  'fk_category': item.fk_category
                }),
        _contentsUpdateAdapter = UpdateAdapter(
            database,
            'contents',
            ['id'],
            (Contents item) => <String, Object?>{
                  'id': item.id,
                  'volume': item.volume,
                  'measure': item.measure,
                  'fk_recipe': item.fk_recipe,
                  'fk_ingrs': item.fk_ingrs
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
        _ingredientDeletionAdapter = DeletionAdapter(
            database,
            'ingredient',
            ['id'],
            (Ingredient item) =>
                <String, Object?>{'id': item.id, 'header': item.header}),
        _recipeDeletionAdapter = DeletionAdapter(
            database,
            'recipe',
            ['id'],
            (Recipe item) => <String, Object?>{
                  'id': item.id,
                  'header': item.header,
                  'description': item.description,
                  'image_path': item.image_path,
                  'fk_category': item.fk_category
                }),
        _contentsDeletionAdapter = DeletionAdapter(
            database,
            'contents',
            ['id'],
            (Contents item) => <String, Object?>{
                  'id': item.id,
                  'volume': item.volume,
                  'measure': item.measure,
                  'fk_recipe': item.fk_recipe,
                  'fk_ingrs': item.fk_ingrs
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final InsertionAdapter<Ingredient> _ingredientInsertionAdapter;

  final InsertionAdapter<Recipe> _recipeInsertionAdapter;

  final InsertionAdapter<Contents> _contentsInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  final UpdateAdapter<Ingredient> _ingredientUpdateAdapter;

  final UpdateAdapter<Recipe> _recipeUpdateAdapter;

  final UpdateAdapter<Contents> _contentsUpdateAdapter;

  final DeletionAdapter<Category> _categoryDeletionAdapter;

  final DeletionAdapter<Ingredient> _ingredientDeletionAdapter;

  final DeletionAdapter<Recipe> _recipeDeletionAdapter;

  final DeletionAdapter<Contents> _contentsDeletionAdapter;

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
  Future<List<Ingredient?>> getAllIngredients() async {
    return _queryAdapter.queryList('SELECT * from ingredient order by header',
        mapper: (Map<String, Object?> row) =>
            Ingredient(row['id'] as int, row['header'] as String));
  }

  @override
  Future<List<Ingredient?>> getIngredientOf(String startwith) async {
    return _queryAdapter.queryList(
        'SELECT * from ingredient where header like ?1',
        mapper: (Map<String, Object?> row) =>
            Ingredient(row['id'] as int, row['header'] as String),
        arguments: [startwith]);
  }

  @override
  Future<List<Recipe>?> getRecipeOfCategory(int id) async {
    return _queryAdapter.queryList(
        'Select id,header,image_path from Recipe where fk_category=?1 order by header',
        mapper: (Map<String, Object?> row) => Recipe(row['id'] as int, row['header'] as String, row['description'] as String, row['image_path'] as String, row['fk_category'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Recipe>?> getRecipeById(int id) async {
    return _queryAdapter.queryList(
        'select id,header,description,image_path from Recipe where id=?1',
        mapper: (Map<String, Object?> row) => Recipe(
            row['id'] as int,
            row['header'] as String,
            row['description'] as String,
            row['image_path'] as String,
            row['fk_category'] as int),
        arguments: [id]);
  }

  @override
  Future<List<dynamic>?> selectDetailedRecipe(int recid) async {
    await _queryAdapter.queryNoReturn(
        'select I.id,I.header,c.measure,C.volumefrom Ingredient I,Contents c inner join on I.id=c.fk_ingrs where C.fk_recipe=?1',
        arguments: [recid]);
  }

  @override
  Future<List<dynamic>?> selectDescRecipe(int recid) async {
    await _queryAdapter.queryNoReturn(
        'select description from recipe where id=?1',
        arguments: [recid]);
  }

  @override
  Future<int?> getIngredientsCount() async {
    await _queryAdapter.queryNoReturn('select count(*) from ingredient');
  }

  @override
  Future<int?> getLastIDCategory() async {
    await _queryAdapter.queryNoReturn('select max(id) from category');
  }

  @override
  Future<int?> getLastIDIngredient() async {
    await _queryAdapter.queryNoReturn('select max(id) from ingredient');
  }

  @override
  Future<List<int>> insertCategories(List<Category> items) {
    return _categoryInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> items) {
    return _ingredientInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertIngredient(Ingredient item) {
    return _ingredientInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertRecipes(List<Recipe> items) {
    return _recipeInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertContents(List<Contents> items) {
    return _contentsInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> UpdateCategories(List<Category> items) {
    return _categoryUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> UpdateIngredients(List<Ingredient> items) {
    return _ingredientUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> UpdateRecipes(List<Recipe> items) {
    return _recipeUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> UpdateContents(List<Contents> items) {
    return _contentsUpdateAdapter.updateListAndReturnChangedRows(
        items, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCategories(List<Category> items) {
    return _categoryDeletionAdapter.deleteListAndReturnChangedRows(items);
  }

  @override
  Future<int> deleteIngredients(List<Ingredient> items) {
    return _ingredientDeletionAdapter.deleteListAndReturnChangedRows(items);
  }

  @override
  Future<int> deleteRecipes(List<Recipe> items) {
    return _recipeDeletionAdapter.deleteListAndReturnChangedRows(items);
  }

  @override
  Future<int> deleteContents(List<Contents> items) {
    return _contentsDeletionAdapter.deleteListAndReturnChangedRows(items);
  }
}
