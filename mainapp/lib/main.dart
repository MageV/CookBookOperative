import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
MyApp({Key key}):super(key:key);

  @override
  _myApp createState(){
    return _myApp();
  }
  // This widget is the root of your application.
}
class _myApp extends State
{
  var _currentPage=0;
  var _pages=["News","List recipes","Add new","Exit"];
  var _icons=[Icon(Icons.add_alert),
  Icon(Icons.waves),
  Icon(Icons.add),
  Icon(Icons.backspace)];

  void _onTap(int inIndex)
  {
    setState(() {
      _currentPage=inIndex;

    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> _items=[];
    for(int i=0;i<_pages.length;i++)
      {
        _items.add(new BottomNavigationBarItem(icon:_icons[i],
            label:_pages[i], backgroundColor: Colors.red));
      }
    return MaterialApp(
      title: "Operative Cookbook",
      home: Scaffold(
      body: Center(
        child: Text(_pages.elementAt(_currentPage)),
      ),
        bottomNavigationBar: BottomNavigationBar(
          items:List.of(_items),
          showUnselectedLabels: true,
          currentIndex: _currentPage,
          selectedItemColor: Colors.amber,
          onTap: _onTap
        ),
      ),
    );
  }

}
