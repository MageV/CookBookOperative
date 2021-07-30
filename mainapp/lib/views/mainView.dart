import 'package:flutter/material.dart';
import 'package:mainapp/services/localizationService.dart';
import 'CategoryView.dart';
import 'RecipesView.dart';
import 'SettingsView.dart';

class MainView extends StatelessWidget {

  final _icons=[
    Image.asset('assets/graphics/icons/ico_001.png',width:32,height:32),
    Image.asset('assets/graphics/icons/ico_002.png',width:32,height:32),
    Image.asset('assets/graphics/icons/ico_003.png',width:32,height:32)
  ];
  final _names=[localizationService().of('header_1'),
    localizationService().of('header_2'),
    localizationService().of('header_3')];
  final List<Tab> _tabBarItems=[];
  MainView();

  @override
  Widget build(BuildContext context) {
    _tabBarItems.clear();
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
