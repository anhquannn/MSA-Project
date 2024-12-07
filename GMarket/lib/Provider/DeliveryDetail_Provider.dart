import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/DeliveryDetail.dart';
import 'package:gmarket/Models/DeliveryDetail.dart';

class DeliveryDetail_Provider extends ChangeNotifier{
  DeliveryDetail? _deliveryDetail;
  List<DeliveryDetail> _deliveryDetails=[];
  bool _loading=false;
  bool _success=false;

  List<DeliveryDetail> get deliveryDetails=>_deliveryDetails;
  DeliveryDetail? get deliveryDetail=>_deliveryDetail;
  bool get loading=>_loading;
  bool get success=>_success;

  Future createDeliveryDetail(DeliveryDetail deli) async{
    _loading=false;
    notifyListeners();
    try{
      final result=await deliveryDetailHttp().createDeliveryDetail(deli);
      if(result!=null){
        _deliveryDetail=result;
      }
    }catch(e){
      throw Exception("Provider - Khong the createDeliveryDetail $e");
    }finally{
      _loading=true;
      notifyListeners();
    }
  }

  Future updateDeliveryDetail(DeliveryDetail deli) async{
    _loading=false;
    notifyListeners();
    try{
      final result=await deliveryDetailHttp().updateDeliveryDetail(deli);
      if(result!=null) {
        _deliveryDetail = result;
      }
    }catch(e){
      throw Exception("Provider - Khong the updateDeliveryDetail $e");
    }finally{
      _loading=true;
      notifyListeners();
    }
  }

  Future deleteDeliveryDetail(int id) async{
    _loading=false;
    notifyListeners();
    try{
      final result=await deliveryDetailHttp().deleteDeliveryDetail(id);
      if(result==true) {
        _success=true;
      }
    }catch(e){
      throw Exception("Provider - Khong the deleteDeliveryDetail $e");
    }finally{
      _loading=true;
      notifyListeners();
    }
  }

  Future getDeliveryDetailById(int id) async {
    _loading = false;
    notifyListeners();
    try {
      final result = await deliveryDetailHttp().getDeliveryDetailById(id);
      if (result != null) {
        _deliveryDetail = result;
      }
    } catch (e) {
      throw Exception("Provider - Khong the getDeliveryDetailById $e");
    } finally {
      _loading = true;
      notifyListeners();
    }
  }

  Future getAllDeliveryDetail() async{
    _loading = false;
    notifyListeners();
    try {
      final result = await deliveryDetailHttp().getAllDeliveryDetail();
      if (result != null) {
        _deliveryDetails = result;
      }
    } catch (e) {
      throw Exception("Provider - Khong the getAllDeliveryDetail $e");
    } finally {
      _loading = true;
      notifyListeners();
    }
  }

  Future getAllDeliveryDetailByDeliveryId(int id) async{
    _loading = false;
    notifyListeners();
    try {
      final result = await deliveryDetailHttp().getAllDeliveryDetailByDeliveryId(id);
      if (result != null) {
        _deliveryDetails = result;
      }
    } catch (e) {
      throw Exception("Provider - Khong the getAllDeliveryDetailByDeliveryId $e");
    } finally {
      _loading = true;
      notifyListeners();
    }
  }

  void setDeliveryDetail(DeliveryDetail deli){
    _deliveryDetail=deli;
    notifyListeners();
  }
  void clearDeliveryDetail(){
    _deliveryDetail=null;
    notifyListeners();
  }
}