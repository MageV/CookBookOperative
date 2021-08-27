import 'package:flutter/material.dart';
import 'package:mainapp/models/WidgetParams.dart';

class SettingsView extends StatefulWidget {

  static const routeName='/SettingsView';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WidgetParams;
    return Container();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
