import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/ReturnOrder.dart';
import 'package:gmarket/Models/ReturnOrder.dart';

class ReturnOrder_Provider extends ChangeNotifier{
  ReturnOrder? _returnorder;
  List<ReturnOrder> _returnorders=[];
  bool _isloading=false;
  int? _orderid;

  int? get orderid=>_orderid;
  ReturnOrder? get returnOrder=>_returnorder;
  List<ReturnOrder> get returnOrders=>_returnorders;
  bool get isloading=>_isloading;

  Future createReturnOrder(ReturnOrder ro)async{
    _isloading=true;
    notifyListeners();
    try{
      final result = await returnOrderHttp().createReturnOrder(ro);
      if(result!=null){
        _returnorder=result;
        print("tao FeedBack thanh cong");
      }
    }catch(e){
      print("Khong the tao FeedBack");
    } finally{
      _isloading=false;
      notifyListeners();
    }
  }

  Future getAllReturnOrder(int id)async{
    _returnorders=[];
    _isloading=true;
    notifyListeners();
    try{
      final result = await returnOrderHttp().getAllReturnOrder();
      _returnorders=result;
        }catch(e){
      print("Provider - Khong the getAllReturnOrder");
    } finally{
      _isloading=false;
      notifyListeners();
    }
  }

  void setorderid(int id){
    _orderid=id;
    notifyListeners();
  }
  void clearorderid(){
    _orderid=null;
    notifyListeners();
  }
}