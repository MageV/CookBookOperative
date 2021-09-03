import 'package:flutter/material.dart';

class RecipeItem extends StatefulWidget {
  RecipeItem({required Key key}) : super(key: key);
  @override
  _RecipeItemState createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  GlobalKey<_RecipeItemState> _key=GlobalKey<_RecipeItemState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode:AutovalidateMode.always ,
      child:Container()
    );
  }
}