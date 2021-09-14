import 'package:flutter/material.dart';

import '../main.dart';


class RecipeItemManual extends StatefulWidget {
  RecipeItemManual({Key? key}) : super(key: key);

  static const routeName = '/RecipeItemManual';
  @override
  _RecipeItemManualState createState() => _RecipeItemManualState();
}

class _RecipeItemManualState extends State<RecipeItemManual> {
  GlobalKey<_RecipeItemManualState> _key=GlobalKey<_RecipeItemManualState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Form(
      key: _key,
      autovalidateMode:AutovalidateMode.always,
          child: new Column(
            children: <Widget>[
              new Text(LocaleService.of('recipe_header')!),
              new TextFormField(validator: (value){
                if(value!.isEmpty) return LocaleService.of('recipe_no_data');
              },
              ),
              new Text(LocaleService.of('recipe_toc')!),

            ],
          ),
    ));
  }
}