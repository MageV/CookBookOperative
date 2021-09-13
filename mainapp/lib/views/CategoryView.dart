import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mainapp/models/WidgetParams.dart';
import 'package:mainapp/models/model.dart';
import 'package:mainapp/services/dbService.dart';
import 'package:mainapp/services/LocalizationService.dart';
import 'package:mainapp/views/IngredientsView.dart';
import 'package:mainapp/views/RecipeItemCamera.dart';


import 'RecipeItemManual.dart';
import 'RecipesView.dart';
import 'SettingsView.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);
  static final String? header = LocalizationService().of('CatView_header');
  static const routeName = "/";

  @override
  State<StatefulWidget> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //  DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
    //]);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // executes after build
    });
  }

  @override
  void dispose() {
    //SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as WidgetParams;
    String? _appHeader = LocalizationService().of('application_header');
    return MaterialApp(
      title: _appHeader!,
      home: Builder(
          builder: (context) =>
              Stack(fit: StackFit.expand, children: <Widget>[
                new Image.asset("assets/graphics/light/backphone2.jpg",
                    fit: BoxFit.cover),
                Scaffold(
                  appBar: AppBar(
                    title: Text(_appHeader + " : " + CategoryView.header!),
                    backgroundColor: Colors.blueGrey.withOpacity(0.3),
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.youtube_searched_for),
                    //backgroundColor: Colors.blueGrey,
                    onPressed: _fabPressed,
                    elevation: 5,
                  ),
                  floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
                  backgroundColor: Colors.transparent,
                  body: new Center(
                    child: new Container(
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.25),
                          borderRadius: BorderRadius.all(Radius.circular(50.0))
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: FutureBuilder<List<Category?>>(
                                future: dbService().DBdao.getAllCategories(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  else {
                                    print("categories got this");
                                    print("category.count:" +
                                        snapshot.data!.length.toString());
                                    return ListView(
                                      padding: EdgeInsets.all(3),
                                      children: snapshot.data!
                                          .map((e) =>
                                          Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.8),
                                                    width: 1),
                                                borderRadius: BorderRadius
                                                    .circular(30)),
                                            child: ListTile(
                                              title: Text(e!.header),
                                              onTap: () =>
                                                  _itemTap(
                                                      e.header, e.id,
                                                      e.image_path, context),
                                              leading: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    e.image_path),
                                              ),
                                            ),
                                          ))
                                          .toList(),
                                    );
                                  }
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: BottomAppBar(
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.description), onPressed: () {
                            _iconPressedIngredients(context);
                          },

                          )
                        ],
                      )
                  ),
                )
              ])),
      routes: {
        RecipesView.routeName: (context) => RecipesView(),
        IngredientsView.routeName: (context) => IngredientsView(),
        SettingsView.routeName: (context) => SettingsView(),
        RecipeItemManual.routeName:(context)=>RecipeItemManual(),

      },
    );
  }

  _itemTap(String item, int id, String path, BuildContext context) {
    WidgetParams params = new WidgetParams.name(item, id, path);
    //print("Pushed"+":"+item+":"+id.toString());
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, RecipesView.routeName, arguments: params);
    });
  }

  _fabPressed() {}

  _iconPressedIngredients(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, IngredientsView.routeName, arguments: null);
    });
  }
}
