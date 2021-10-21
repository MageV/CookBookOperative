//import 'package:flutter/cupertino.dart';
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
  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _IngrsController = TextEditingController();
  final TextEditingController _processController = TextEditingController();
  final List<String> _values=List.filled(3,"");

  @override
  void dispose() {
    _headerController.dispose();
    _IngrsController.dispose();
    _processController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _headerController.addListener(_onHeaderListener);
    _IngrsController.addListener(_onToCListener);
    _processController.addListener(_onProcessListner);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RecipeParams;
    final String header = args.Header ?? "";
    final String Ingrs = args.Ingredients ?? "";
    final String path2File = args.path2File ?? "";
    final String process = args.process ?? "";
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
                    controller: _headerController,
                    initialValue: header,
                    autocorrect: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  Text(LocaleService.of('recipe_toc')!),
                  TextFormField(
                      controller: _IngrsController,
                      initialValue: Ingrs,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  Text(LocaleService.of('recipe_desc')!),
                  TextFormField(
                      controller: _processController,
                      initialValue: process,
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
                onPressed: _onPressed(formAction.faSave, context),
                child: Icon(Icons.assignment_returned),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green))),
            ElevatedButton(
                onPressed: _onPressed(formAction.faCancel, context),
                child: Icon(Icons.arrow_back),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red))),
            ElevatedButton(
                onPressed: _onPressed(formAction.faRecordAudio, context),
                child: Icon(Icons.voicemail_rounded),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue))),
          ],
        ),
      ),
    );
  }

  _onHeaderListener()
  {
    _values[0]=_headerController.text;
  }

  _onToCListener()
  {
    _values[1]=_IngrsController.text;
  }
  _onProcessListner()
  {
    _values[2]=_processController.text;
  }
  _onPressed(formAction action, BuildContext context) {
    switch (action) {
      case formAction.faSave:
        {
          break;
        }
      case formAction.faCancel:
        {
          Navigator.pop(context);
          break;
        }
      case formAction.faRecordAudio:
        {
          break;
        }
    }
  }
}
