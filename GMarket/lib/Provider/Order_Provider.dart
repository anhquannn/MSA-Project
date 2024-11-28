
import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/Order.dart';
import 'package:gmarket/Models/Order.dart';
import 'package:gmarket/Models/previewOrder.dart';

class Order_Provider extends ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  Order? _order;
  bool _isSucess = false;
  PreviewOrder _previewOrder=new PreviewOrder(total_cost: 0, discount: 0, grand_total: 0);

  PreviewOrder get previewOrder => _previewOrder;
  bool get isSucess => _isSucess;
  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  Order? get order => _order;

  Future createOrder(Order od, String pc) async {
    _isSucess = false;
    _isLoading = true;
    notifyListeners();
    try {
      final result = await orderHttp().createOrder(od, pc);
      if (result != null) {
        _order = result;
        _isSucess = true;
        notifyListeners();
        print("Provider - Tao Order thanh cong");
      }
    } catch (e) {
      print("Provider - Khong the tao Order: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future deleteOrder(int id) async {
    _setLoading(true);
    try {
      final result = await orderHttp().deleteOrder(id);
      if (result == true) {
        print("Delete Order thanh cong");
        _orders.removeWhere((order) => order.ID == id);
      }
    } catch (e) {
      print("Khong the delete Order: $e");
    }
    _setLoading(false);
  }

  Future getOrderById(int id) async {
    _setLoading(true);
    try {
      final result = await orderHttp().getOrderById(id);
      if (result != null) {
        _order = result;
      }
    } catch (e) {
      print("Khong the lay Order: $e");
    }
    _setLoading(false);
  }

  Future getAllOrder() async {
    _setLoading(true);
    try {
      final result = await orderHttp().getAllOrder();
      if (result != null) {
        _orders = result;
      }
    } catch (e) {
      print("Khong the lay Order: $e");
    }
    _setLoading(false);
  }

  Future searchOrderByNumberPhone(String phoneNumber) async {
    _setLoading(true);
    try {
      final result = await orderHttp().searchOrderByNumberPhone(phoneNumber);
      if (result != null) {
        _orders = result;
      }
    } catch (e) {
      print("Khong the lay Order: $e");
    }
    _setLoading(false);
  }

  void clearOrder() {
    _order = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearOrders() {
    this._orders = [];
  }

  Future getOrderHistory(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final list = await orderHttp().getOrderHistory(userId);
      if (list != null) {
        _orders = list;
      }
    } catch (e) {
      throw Exception("Provider - Khong the getOrderHistory $e");
    }
  }

  Future getPreviewOrder(int user_id, int cart_id, String promo_code) async {
    _isLoading = true;
    notifyListeners();
    try {
      final po = await orderHttp().getPreviewOrder(user_id, cart_id, promo_code);
      if (po != null) {
        _previewOrder = po;
        print("Provider - getPreviewOrder thanh cong ${_previewOrder}");
      }
    } catch (e) {
      throw Exception("Provider - getPreviewOrder thanh cong $e");
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearPreviewOrder(){
    _previewOrder=new PreviewOrder(total_cost: 0, discount: 0, grand_total: 0);
  }
}