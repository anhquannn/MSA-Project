import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/PromoCode.dart';
import 'package:gmarket/Models/Promocode.dart';

class Promocode_Provider extends ChangeNotifier {
  List<PromoCode> _promocodes = [];
  PromoCode? _promocodeSearch;
  PromoCode? _promocode;
  bool _isLoading = false;
  int _index=0;

  int get index=>_index;
  List<PromoCode> get promocodes => _promocodes;
  PromoCode? get promocodeSearch => _promocodeSearch;
  PromoCode? get promocode => _promocode;
  bool get isLoading => _isLoading;

  Future createPromoCode(PromoCode p) async {
    _isLoading = true;
    notifyListeners();
    final result = await promoCodeHttp().createPromoCode(p);
    if (result == true) {
      _isLoading=false;
    } else {
      print("Provider thêm thất bại");
    }
  }

  Future updatePromoCode(PromoCode promocode) async {
    _isLoading = true;
    notifyListeners();
    final result = await promoCodeHttp().updatePromoCode(promocode);
    if (result == true) {
      _isLoading=true;
    } else {
      print("Provider update thất bại");
    }
  }

  Future deletePromoCode(int id) async {
    _isLoading = true;
    notifyListeners();
    final result = await promoCodeHttp().deletePromoCode(id);
    if (result == true) {
      _isLoading=true;
    } else {
      print("Provider delete thất bại");
    }
  }

  Future getPromoCodeById(int id) async {
    clearPromoCodeSearch();
    _isLoading = true;
    notifyListeners();
    final result = await promoCodeHttp().getPromoCodeById(id);
    if (result != null) {
      _promocodeSearch = result;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future getPromocodeByCode(String code) async{
    clearPromoCodeSearch();
    _isLoading = true;
    notifyListeners();
    final result = await promoCodeHttp().getPromocodeByCode(code);
    if (result != null) {
      _promocodeSearch = result;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future getAllPromoCode() async{
    _isLoading = true;
    notifyListeners();
    final result = await promoCodeHttp().getAllPromoCode();
    if (result != null) {
      _promocodes = result;
      print("Provider - getAllPromoCode thanh cong ${_promocodes}");
    }
    _isLoading = false;
    notifyListeners();
  }

  void clearPromoCodeSearch(){
    this._promocodeSearch=null;
  }

  void setIndex(int id){
    _index=id;
    notifyListeners();
  }
}
