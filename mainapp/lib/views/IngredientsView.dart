import 'package:flutter/material.dart';
import 'package:mainapp/models/model.dart';
import 'package:mainapp/services/dbService.dart';
import 'package:mainapp/services/localizationService.dart';

class IngredientsView extends StatefulWidget {
  const IngredientsView({Key? key}) : super(key: key);

  static const routeName = '/IngredientsView';

  @override
  _IngredientsViewState createState() => _IngredientsViewState();
}



class _IngredientsViewState extends State<IngredientsView> {
  String? _appHeader = LocalizationService().of('application_header');
  List<Ingredient> ingrList = [];
  List<String> strList = [];
  List<Widget> favouriteList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();

  filterList()
  {
    List<Ingredient> ingredients=[];
    ingredients.addAll(ingrList);
  }

  @override
  initState() {
    searchController.addListener(() {
      filterList();
    });
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(_appHeader!),
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          //backgroundColor: Colors.blueGrey,
          onPressed: _fabPressed,
          elevation: 5,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder<List<Ingredient?>>(
            future: dbService().DBdao.getAllIngredients(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {

              }
            })
    );
  }

  _fabPressed() {}
}
