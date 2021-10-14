import 'package:flutter/material.dart';
import 'package:mainapp/models/WidgetParams.dart';
import 'package:mainapp/models/model.dart';


import '../main.dart';
import 'RecipeItemCamera.dart';
import 'RecipeItemManual.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key}) : super(key: key);
  static const routeName = '/RecipesView';
  @override
  _RecipesViewState createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // executes after build
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WidgetParams;
    int _id = args.category_id;
    String _header = args.title;
    String _path=args.path;
    _path=_path.replaceAll(".png", "_back.jpg");
    return new Stack(
        fit: StackFit.expand,
        children: <Widget>[
     new Image.asset(_path,
                fit: BoxFit.cover),
      Scaffold(
        appBar: AppBar(title: Text(_header),
            backgroundColor: Colors.blueGrey.withOpacity(0.3)),
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _fabPressed(context),
          elevation: 5,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: <Widget>[
            Expanded(
                child: FutureBuilder<List<Recipe>?>(
                    future: DBService.DBdao.getRecipeOfCategory(_id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView(
                        padding: EdgeInsets.all(3),
                        children: snapshot.data!
                            .map((e) => Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: ListTile(
                                  title: Text(e.header),
                                  onTap: _itemTap(e.header, e.id, context),
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(e.image_path),
                                  ),
                                )))
                            .toList(),
                      );
                    }))
          ],
        ),
      )
    ]);
  }

  _itemTap(String header, int id, BuildContext context) {}

  _runManual(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, RecipeItemManual.routeName, arguments: null);
    });

  }
  _runCamera(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, RecipeItemCamera.routeName, arguments: null);
    });
  }
  _runWeb(BuildContext context)
  {

  }

  _fabPressed(BuildContext context) {
    String? dialogHeader = LocaleService.of('dialog_item_new_header');
    String? optionsMan = LocaleService.of('dialog_item_new_manual');
    String? optionsCam = LocaleService.of('dialog_item_new_camera');
    String? optionsWeb=LocaleService.of('dialog_item_new_web');
    String? dialogCancel = LocaleService.of('dialog_item_cancel');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
              child: SimpleDialog(
            title: Text(dialogHeader!),
            children: <Widget>[
              SimpleDialogOption(
                  onPressed: () => _runManual(context),
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(optionsMan!),
                        leading: CircleAvatar(child: Icon(Icons.waves)),
                      ))),
/*              SimpleDialogOption(
                  onPressed: () => _runCamera(context),
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(optionsCam!),
                        leading: CircleAvatar(
                            child: Icon(Icons.add_a_photo_rounded)),
                      ))),*/
              SimpleDialogOption(
                  onPressed: () => _runWeb(context),
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(optionsWeb!),
                        leading: CircleAvatar(child: Icon(Icons.clear)),
                      ))),
              SimpleDialogOption(
                  onPressed: () => Navigator.pop(context),
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(dialogCancel!),
                        leading: CircleAvatar(child: Icon(Icons.clear)),
                      )))
            ],
          ));
        });
  }
}
