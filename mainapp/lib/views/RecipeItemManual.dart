import 'package:flutter/cupertino.dart';
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
        return Scaffold(
          appBar: AppBar(title: Text(LocaleService.of('dialog_item_new_header')!)),
            body:Form(
              key: this._key,
            child:Padding(
            padding: const EdgeInsets.all(32.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Text(LocaleService.of('recipe_header')!),
              TextFormField(
                autocorrect: true,
                decoration:InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              Text(LocaleService.of('recipe_toc')!),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines:null,
                decoration:InputDecoration(
                    border: OutlineInputBorder()
                )
              ),
            ],
          )
            )
            )
        );
  }

  _onPressed(int field_id)
  {

  }
}