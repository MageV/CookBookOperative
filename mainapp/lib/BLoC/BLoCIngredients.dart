
import 'package:mainapp/%20db/dbController.dart';
import 'package:mainapp/BLoC/BaseBLoC.dart';
import 'package:mainapp/models/BaseModel.dart';
import 'package:mainapp/models/IngredientsItem.dart';

class BLoCIngredients extends BaseBLoC
{
  BLoCIngredients(DBController repository) : super(repository);
  final String _tableName=IngredientsItem.tableName;

  @override
  void loadData(Map<String, dynamic> parameters) {
    super.baseStreamController.sink.add(baseState.baseLoading());
    String _method=parameters["Method"];
    final List<IngredientsItem> items=[];
    switch(_method)
    {
      case "QALL":
        {
          items.clear();
          super.repository.queryAll(_tableName).then((value) => items);
          super.baseStreamController.sink.add(baseState.baseData(items));
          break;
        }
      case "QID":
        {
          items.clear();
          int id=parameters["ID"];
          super.repository.queryById(_tableName, id).then((value) => items);
          super.baseStreamController.sink.add(baseState.baseData(items));
          break;
        }
      case "QHD":
        {
          items.clear();
          String header=parameters["header"];
          super.repository.queryByHeader(_tableName, header).then((value) => items);
          super.baseStreamController.sink.add(baseState.baseData(items));
        }
    }

  }

  @override
  void saveData(String table, BaseModel data) {
    // TODO: implement saveData
  }

}