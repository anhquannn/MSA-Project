import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/Manufaturer.dart';
import 'package:gmarket/Models/Manufacturer.dart';

class Manufacturer_Provider extends ChangeNotifier{
  List<Manufacturer> _listManufacturer=[];
  bool _isLoading=false;
  Manufacturer? _manufacturer;

  List<Manufacturer> get listManufacturer=>_listManufacturer;
  bool get isLoading=>_isLoading;
  Manufacturer? get manufacturer=>_manufacturer;

  Future getAllManufacturer()async{
    _isLoading=true;
    notifyListeners();
    try{
      List<Manufacturer> manu=await manufacturerHttp().getAllManufacturer();
      _listManufacturer=manu;
        }catch(e){
      print("Provider - Khong the lay  Manufacturer $e");
    } finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future createManufacturer(Manufacturer manu)async{
    final result=await manufacturerHttp().createManufaturer(manu);
    if(result==true){
      getAllManufacturer();
    }else{
      print("Provider - Khong the tao Manufacturer");
    }
  }

  Future updateManufacturer(Manufacturer manu)async{
    final result=await manufacturerHttp().updateManufacturer(manu);
    if(result==true){
      getAllManufacturer();
    }else{
      print("Provider - Khong the update Manufacturer");
    }
  }

  Future deleteManufacturer(int id) async{
    final result=await manufacturerHttp().deleteManufacturer(id);
    if(result==true){
      getAllManufacturer();
    }else{
      print("Provider - Khong the delete Manufacturer");
    }
  }

  Future getManufacturerById(int id) async{
    _manufacturer=null;
    _isLoading=true;
    notifyListeners();
    final result=await manufacturerHttp().getManufacturerById(id);
    if(result!=null){
      _manufacturer=result;
    }else{
      print("Provider - Khong the get category");
    }
    _isLoading=false;
    notifyListeners();
  }
}