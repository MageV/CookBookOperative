import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mainapp/models/RecipeParams.dart';
import 'package:path/path.dart';

import '../main.dart';

enum formAction { faSave, faCancel, faRecordAudio }

class RecipeItemManual extends StatefulWidget {
  RecipeItemManual({Key? key}) : super(key: key);

  static const routeName = '/RecipeItemManual';
  @override
  _RecipeItemManualState createState() => _RecipeItemManualState();
}

class _RecipeItemManualState extends State<RecipeItemManual> {
  GlobalKey<_RecipeItemManualState> _key = GlobalKey<_RecipeItemManualState>();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RecipeParams;
    final String header=args.Header ?? "";
    final String Ingrs=args.Ingredients ?? "";
    final String path2File=args.path2File ?? "";
    final String process=args.process ?? "";
    return Scaffold(
      appBar: AppBar(title: Text(LocaleService.of('dialog_item_new_header')!)),
      body: Form(
          key: this._key,
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(LocaleService.of('recipe_header')!),
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  Text(LocaleService.of('recipe_toc')!),
                  TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                ],
              ))),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
                onPressed: _onPressed(formAction.faSave),
                child: Icon(Icons.assignment_returned),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green))),
            ElevatedButton(
                onPressed: _onPressed(formAction.faCancel),
                child: Icon(Icons.arrow_back),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red))),
            ElevatedButton(
                onPressed: _onPressed(formAction.faRecordAudio),
                child: Icon(Icons.voicemail_rounded),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue))),
          ],
        ),
      ),
    );
  }

  _onPressed(formAction action) {
     switch(action)
     {
       case formAction.faSave:
         {
           break;
         }
       case formAction.faCancel:
         {
           break;
         }
       case formAction.faRecordAudio:
         {
           break;
         }
     }
  }
}
