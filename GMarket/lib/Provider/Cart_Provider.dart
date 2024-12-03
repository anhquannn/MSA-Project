import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/Cart.dart';
import 'package:gmarket/Models/Cart.dart';

class Cart_Provider extends ChangeNotifier{
  bool _isLoading=false;
  Cart? _cart;

  bool get isLoading =>_isLoading;
  Cart? get cart=>_cart;

  Future createCategory(Cart c)async{
    _isLoading=true;
    notifyListeners();
    final result=await cartHttp().createCart(c);
    if(result==true){
      _isLoading=false;
      notifyListeners();
    }else{
      print("Provider - Khong the tao Cart");
    }
  }

  Future updateCart(Cart c)async{
    _isLoading=true;
    notifyListeners();
    final result=await cartHttp().updateCart(c);
    if(result==true){
      _isLoading=false;
      notifyListeners();
    }else{
      print("Provider - Khong the update category");
    }
  }

  Future deleteCart(int id) async{
    _isLoading=true;
    notifyListeners();
    final result=await cartHttp().deleteCart(id);
    if(result==true){
      _isLoading=false;
      notifyListeners();
    }else{
      print("Provider - Khong the delete category");
    }
  }

  Future getCartById(int id) async{
    _cart=null;
    _isLoading=true;
    notifyListeners();
    try{
      final result=await cartHttp().getCartById(id);
      if(result!=null){
        _cart=result;
      }else{
        print("Provider - Khong the get category");
      }
    }catch(e){
      Exception('$e');
    }
    finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future getOrCreateCartForUser(int userId)async{
    _cart=null;
    _isLoading=true;
    notifyListeners();
    try{
      final result=await cartHttp().getOrCreateCartForUser(userId);
      if(result!=null){
        _cart=result;
        print("Provider cart_id ${_cart!.ID}");
      }else{
        print("Provider - Khong the get getOrCreateCartForUser - UserId = $userId");
      }
    }catch(e){
      Exception('Provider getOrCreateCartForUser Trycatch$e');
    }
    finally{
      _isLoading=false;
      notifyListeners();
    }
  }
}