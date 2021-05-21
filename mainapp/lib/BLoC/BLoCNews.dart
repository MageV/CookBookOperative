import 'package:mainapp/%20db/dbController.dart';
import 'package:mainapp/BLoC/BaseBLoC.dart';
import 'package:mainapp/models/BaseModel.dart';
import 'package:mainapp/models/NewsItem.dart';

class BLoCNews extends BaseBLoC {
  dbController _repository;

  BLoCNews(dbController repository) : super(repository) {
    this._repository = repository;
  }

  @override
  void loadData(Map<String, dynamic> parameters) {
    super.baseStreamController.sink.add(baseState.baseLoading());
    String methodname = parameters["Method"];
    String tablename = parameters["Table"];
    final List<NewsItem> items = [];
    switch (methodname) {
      case "QALL":
        {
          items.clear();
          _repository.queryAll(tablename).then((value) => items);
          super.baseStreamController.sink.add(baseState.baseData(items));
          break;
        }
      case "QID":
        {
          items.clear();
          int id=parameters["ID"];
          _repository.queryById(tablename, id).then((value) => items);
          super.baseStreamController.sink.add(baseState.baseData(items));
          break;
        }
      case "QHD":
        {
          items.clear();
          String header=parameters["header"];
          _repository.queryByHeader(tablename, header).then((value) => items);
          super.baseStreamController.sink.add(baseState.baseData(items));
        }
    }
  }

  @override
  void saveData(String table, BaseModel data) {
    // TODO: implement saveData
  }
}