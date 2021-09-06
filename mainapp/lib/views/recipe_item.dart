import 'package:flutter/material.dart';
import 'package:mainapp/services/localizationService.dart';

class RecipeItem extends StatefulWidget {
  RecipeItem({required Key key}) : super(key: key);
  @override
  _RecipeItemState createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  GlobalKey<_RecipeItemState> _key=GlobalKey<_RecipeItemState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Form(
      key: _key,
      autovalidateMode:AutovalidateMode.always,
          child: new Column(
            children: <Widget>[
              new Text(LocalizationService().of('recipe_header')!),
              new TextFormField(validator: (value){
                if(value!.isEmpty) return LocalizationService().of('recipe_no_data');
              },
              ),
              new Text(LocalizationService().of('recipe_toc')!),

            ],
          ),
    ));
  }
}