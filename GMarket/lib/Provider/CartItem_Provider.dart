
import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/CartItem.dart';
import 'package:gmarket/Models/CartItem.dart';

class CartItem_Provider extends ChangeNotifier{
  bool _isLoading=false;
  CartItem? _cartItem;
  List<CartItem> _cartItems=[];
  bool _isSucess=false;
  List<int> _listid =[];
  bool _state=false;

  bool get state=>_state;
  List<int> get listid => _listid;
  bool get isLoading =>_isLoading;
  bool get isSucess =>_isSucess;
  CartItem? get cart=>_cartItem;
  List<CartItem>? get cartItems=> _cartItems;



  Future addProductToCart(CartItem c)async{
    _isLoading=true;
    notifyListeners();
    final result=await cartItemHttp().addProductToCart(c);
    if(result!=null){
      _cartItem=result;
      _isLoading=false;
      notifyListeners();
      print("Provider - tao addProductToCart");
    }else{
      print("Provider - Khong the tao addProductToCart");
    }
  }

  Future updateCartItem(CartItem c)async{
    _isLoading=true;
    notifyListeners();
    final result=await cartItemHttp().updateCartItem(c);
    if(result==true){
      getCartItemByID(c.ID!);
      _isLoading=false;
      notifyListeners();
    }else{
      print("Provider - Khong the update category");
    }
  }

  Future deleteCartItem(int id) async{
    _isLoading=true;
    notifyListeners();
    final result=await cartItemHttp().deleteCartItem(id);
    if(result==true){
      _isLoading=false;
      notifyListeners();
    }else{
      print("Provider - Khong the delete category");
    }
  }

  Future getCartItemByID(int id) async{
    _cartItem=null;
    _isLoading=true;
    notifyListeners();
    try{
      final result=await cartItemHttp().getCartItemByID(id);
      if(result!=null){
        _cartItem=result;
      }else{
        print("Provider - Khong the get getCartItemByID $id");
      }
    }catch(e){
      Exception('$e');
    }
    finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future clearCart(int id) async{
    _isLoading=true;
    notifyListeners();
    try{
      final result=await cartItemHttp().clearCart(id);
      if(result!=null){
        _isLoading=false;
        notifyListeners();
      }else{
        print("Provider - Khong the get category $id");
      }
    }catch(e){
      Exception('$e');
    }
  }

  Future getCartItemsByCartID(int id)async{
    _cartItems=[];
    _isLoading=true;
    notifyListeners();
    try{
      final result=await cartItemHttp().getCartItemsByCartID(id);
      if(result!=null){
        _cartItems=result;
        print("Provider - getCartItemsByCartID thanh cong $_cartItems cartId: $id");
      }else{
        print("Provider - Khong the getCartItemsByCartID");
      }
    }catch(e){
      Exception('$e');
    }
    finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future setQuantity(int t) async{
    _cartItem?.quantity=t;
    updateCartItem(_cartItem!);
    notifyListeners();
  }

  Future updateCartItemStatus(List<int> listCartItemId, String status) async{
    _isLoading=true;
    notifyListeners();
    try{
      if(await cartItemHttp().updateCartItemsStatus(listCartItemId, status)==true){
        print("Provider updateCartItemStatus thanh cong -- $status");
      }
      else{
        print("Provider updateCartItemStatus khong thanh cong");
      }
    }catch(e){
      print("Provider updateCartItemStatus khong thanh cong $e");
    }
    _isLoading==false;
    notifyListeners();
  }

  Future getAllCartItemsByCartID(int cartId) async{
    _cartItems=[];
    _isSucess=false;
    _isLoading=true;
    notifyListeners();
    try{
      final list= await cartItemHttp().getAllCartItemsByCartID(cartId);
      if(list!=null){
        _cartItems=list;
        print("Provider getAllCartItemsByCartID ${_cartItems[0].ID}");

        _isLoading=false;
        _isSucess=true;
        notifyListeners();
      }
      else{
        print("Provider khong the getAllCartItemsByCartID ${_cartItems[0].ID}");
      }
    }catch(e){
      throw Exception("provider -  khong the getAllCartItemsByCartID cartId: $cartId -:- $e");
    }
    notifyListeners();
  }

  void addIdToList(int id) {
    _listid.add(id);
    print("list id added: ${_listid}  -- $id");
    notifyListeners();
  }

  void removeIdFromList(int id) {
    _listid.remove(id);
    print("list id remove: ${_listid}  -- $id");
    notifyListeners();
  }

  void clearListId(){
    _listid=[];
  }

  void chooseAll(){
    if(_state){
      _state=false;
      print(_state);
      notifyListeners();
    }
    else{
      _state=true;
      print(_state);
      notifyListeners();
    }
  }

  void clearCartItems(){
    _cartItems=[];
    notifyListeners();
  }
}