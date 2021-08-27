import 'package:flutter/material.dart';
import 'package:mainapp/models/WidgetParams.dart';
import 'package:mainapp/models/model.dart';
import 'package:mainapp/services/dbService.dart';
import 'package:mainapp/services/localizationService.dart';


class CategoryView extends StatelessWidget {

  final String? header=localizationService().of('CatView_header');
  static const routeName="/CategoryView";
  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as WidgetParams;
     return Scaffold(
        appBar: AppBar(
          title: Text(header!),
        ),
        backgroundColor: Colors.blue,
        body:Column(
          children: <Widget>[
            Expanded(
                child: FutureBuilder<List<Category?>>(
                  future: dbService().DBdao.getAllCategories(),
                  builder: (context,snapshot)
                  {
                    if(!snapshot.hasData)
                      return Center(child:CircularProgressIndicator());
                    return ListView(
                      padding: EdgeInsets.all(3),
                      children: snapshot.data!
                      .map((e) => Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          title: Text(e!.header),
                          onTap: itemTap(e.header),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(e.image_path),
                          ),
                        ),
                      )).toList(),
                    );
                  },
                ))
          ],
        )
      );
  }

  itemTap(String item)
  {

  }

}