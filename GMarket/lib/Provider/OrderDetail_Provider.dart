import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/OrderDetail.dart';
import 'package:gmarket/Models/OrderDetail.dart';

class OrderDetail_Provider extends ChangeNotifier {
  bool _isLoading = false;
  OrderDetail? _orderDetail;
  
  bool get isLoading => _isLoading;
  OrderDetail? get manufacturer => _orderDetail;

  Future createOrderDetail(OrderDetail od) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await orderDetailHttp().createOrderDetail(od);
      if (result == true) {
        print("Tao OrderDetail thanh cong");
      }
    } catch (e) {
      print("Khong the tao  OrderDetail");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future updateOrderDetail(OrderDetail od) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await orderDetailHttp().updateOrderDetail(od);
      if (result == true) {
        print("updateOrderDetail thanh cong");
      }
    } catch (e) {
      print("Khong the updateOrderDetail");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future deleteOrderDetail(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await orderDetailHttp().deleteOrderDetail(id);
      if (result == true) {
        print("delete Order thanh cong");
      }
    } catch (e) {
      print("Khong the delete  Order");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future getOrderDetailById(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await orderDetailHttp().getOrderDetailById(id);
      if (result !=null) {
        _orderDetail=result;
      }
    } catch (e) {
      print("Khong the get  Order");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}