import 'dart:async';

import 'package:mainapp/%20db/dbController.dart';
import 'package:mainapp/models/BaseModel.dart';

abstract class BaseBLoC
{
  BaseBLoC(this._repository);
  final dbController _repository;
  final baseStreamController=StreamController<baseState>();
  Stream<baseState> get base=>baseStreamController.stream;
  void loadData(Map<String,dynamic> paramters);
  void saveData(String table,BaseModel data);
  void dispose()
  {
    baseStreamController.close();
  }
}

class baseState
{
  baseState();
  factory baseState.baseData(List<BaseModel> model)=baseDataState;
  factory baseState.baseLoading()=baseLoadingState;
}

abstract class baseInitState extends baseState
{

}
class baseLoadingState extends baseState
{
  baseLoadingState();

}
class baseDataState extends baseState
{
  final List<BaseModel> model;
  baseDataState(this.model);
}