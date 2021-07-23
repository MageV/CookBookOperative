import 'package:flutter/material.dart';
import 'package:mainapp/models/model.dart';
import 'CategoryView.dart';
import 'RecipesView.dart';
import 'SettingsView.dart';

class MainView extends StatelessWidget {

  final _icons=[
    Icon(Icons.article),
    Icon(Icons.waves),
    Icon(Icons.settings)
  ];
  final _names=["Recipes","News line","Settings"];
  final List<Tab> _tabBarItems=[];
  MainView();

  @override
  Widget build(BuildContext context) {
    for(int i=0;i<_names.length;i++)
      {
        _tabBarItems.add(new Tab(text:_names[i],icon: _icons[i]));
      }
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Operative cookbook"),
            bottom: TabBar(
              tabs: List.of(_tabBarItems)
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage('assets/graphics/light/backphone.jpg'),
                fit: BoxFit.cover
              ),
            ),
            child: TabBarView(
              children: [
                CategoryView(),RecipesView(),SettingsView()
              ],
            ),
          )
        ),
      ),
    );
  }

}
