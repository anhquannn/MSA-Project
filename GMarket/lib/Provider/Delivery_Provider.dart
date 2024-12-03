import 'package:flutter/widgets.dart';
import 'package:gmarket/Http/Delivery.dart';
import 'package:gmarket/Models/Delivery.dart';

class Delivery_Provider extends ChangeNotifier{
  List<Delivery> _deliveries=[];
  bool isLoading=false;
  Delivery? _delivery;
  bool _issuccess=false;

  List<Delivery> get deliveries =>_deliveries;
  bool get loading =>isLoading;
  bool get isSuccess =>_issuccess;
  Delivery? get delivery=>_delivery;

  Future createDelivery(Delivery deli, int userId, int orderId)async{
    isLoading=true;
    notifyListeners();
    try{
      final result=await deliveryHttp().createDelivery(deli, userId, orderId);
      if(result!=null){
        _delivery=result;
      }
    }catch(e){
      throw Exception("Provider - Khong the createDelivery $e");
    }
    finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future updateDelivery(Delivery deli)async{
    isLoading=true;
    notifyListeners();
    try{
      final result=await deliveryHttp().updateDelivery(deli);
      if(result!=null){
        _delivery=result;
      }
    }catch(e){
      throw Exception("Provider - Khong the updateDelivery $e");
    }
    finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future deleteDelivery(int id) async{
    isLoading=true;
    notifyListeners();
    try{
      final result=await deliveryHttp().deleteDelivery(id);
      if(result==true){
        _issuccess=true;
        notifyListeners();
      }
    }catch(e){
      throw Exception("Provider - Khong the deleteDelivery $e");
    }
    finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future getDeliveryById(int id) async{
    isLoading=true;
    notifyListeners();
    try{
      final result=await deliveryHttp().getDeliveryById(id);
      if(result!=null){
        _delivery=result;
      }
    }catch(e){
      throw Exception("Provider - Khong the getDeliveryById $e");
    }
    finally{
      isLoading=false;
      notifyListeners();
    }
  }
}