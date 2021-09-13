import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  filterList() {
    List<Ingredient> ingredients = [];
    ingredients.addAll(ingrList);
    ingredients.sort(
        (a, b) => a.header.toLowerCase().compareTo(b.header.toLowerCase()));
    normalList = [];
    strList = [];
    if (searchController.text.isNotEmpty) {
      ingredients.retainWhere((element) => element.header
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }
    ingredients.forEach((element) {
      normalList.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Text(element.header)));
      strList.add(element.header);
    });
    setState(() {});
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
                snapshot.data!.map((e) => normalList).toList();
                return AlphabetListScrollView(
                  strList: strList,
                  highlightTextStyle: TextStyle(
                    color: Colors.orange,
                  ),
                  showPreview: true,
                  itemBuilder: (context, index) {
                    return normalList[index];
                  },
                  indexedHeight: (i) {
                    return 80;
                  },
                  keyboardUsage: true,
                  headerWidgetList: <AlphabetScrollListHeader>[
                    AlphabetScrollListHeader(widgetList: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffix: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            labelText: "Search",
                          ),
                        ),
                      )
                    ], icon: Icon(Icons.search), indexedHeaderHeight: (index) => 80),
                  ],
                );
              }
            })
    );
  }

  _fabPressed() {}
}
