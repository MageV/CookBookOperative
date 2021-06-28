import 'package:mainapp/models/model.dart';

class dbService{
  dbService._privateConstructor();
  static final dbService _instance=dbService._privateConstructor();
  factory dbService()
  {
    return _instance;
  }
  late DbDao DBdao;
  init(DbDao dao)
  async {
    DBdao=dao;
    List<Category> catInit=[];
    if( (await DBdao.getCategoryCount())==0)
    {

    }
  }

}