
import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/Order.dart';
import 'package:gmarket/Models/Order.dart';
import 'package:gmarket/Models/previewOrder.dart';

class Order_Provider extends ChangeNotifier {
  List<Order> _orders = [];
  List<Order> _paying = [];
  List<Order> _delivering = [];
  List<Order> _success = [];
  List<Order> _returned = [];
  List<Order> _pending = [];
  bool _isLoading = false;
  bool _isSucess = false;
  Order? _order;
  PreviewOrder _previewOrder=new PreviewOrder(total_cost: 0, discount: 0, grand_total: 0);
  final List<int> _listproductid=[];

  List<int> get list_idproduct=>_listproductid;
  PreviewOrder get previewOrder => _previewOrder;
  bool get isSucess => _isSucess;
  bool get isLoading => _isLoading;
  Order? get order => _order;
  List<Order> get orders => _orders;
  List<Order> get paying => _paying;
  List<Order> get delivering => _delivering;
  List<Order> get success => _success;
  List<Order> get returned => _returned;
  List<Order> get pending => _pending;

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
      }
    } catch (e) {
    }
    _isLoading = false;
    notifyListeners();
  }

  Future deleteOrder(int id) async {
    _setLoading(true);
    try {
      final result = await orderHttp().deleteOrder(id);
      if (result == true) {
        _orders.removeWhere((order) => order.ID == id);
      }
    } catch (e) {
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
    }
    _setLoading(false);
  }

  Future getAllOrder() async {
    _setLoading(true);
    try {
      final result = await orderHttp().getAllOrder();
      _orders = result;
        } catch (e) {
    }
    _setLoading(false);
  }

  Future fillOrder(int page) async {
    _setLoading(true);
    try {
      final result = await orderHttp().fillOrder(page);
      _orders +=result;
        } catch (e) {
    }
    _setLoading(false);
  }

  Future searchOrderByNumberPhone(String phoneNumber) async {
    notifyListeners();
    try {
      final result = await orderHttp().searchOrderByNumberPhone(phoneNumber);
      _orders = result;
      print("Provider - searchOrderByNumberPhone thanh cong");
    } catch (e) {
      print("Provider - khong the searchOrderByNumberPhone $e");
    }
    notifyListeners();
  }

  Future getOrderHistory(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final list = await orderHttp().getOrderHistory(userId);
      _orders = list;
      notifyListeners();
        } catch (e) {
      throw Exception("Provider - Khong the getOrderHistory $e");
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future getPreviewOrder(int user_id, int cart_id, String promo_code) async {
    _isLoading = true;
    notifyListeners();
    try {
      final po = await orderHttp().getPreviewOrder(user_id, cart_id, promo_code);
      if (po != null) {
        _previewOrder = po;
      }
    } catch (e) {
      throw Exception("Provider - getPreviewOrder thanh cong $e");
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future updateStatusOrder(int orderId,int userId, int cartId, String status) async{
    _isLoading=true;
    notifyListeners();
    try{
      final result= await orderHttp().updateStatusOrder(orderId, userId, cartId, status);
      if(result!=null){
        _order=result;
      }
    }catch(e){
      throw Exception("Provider - khong the updateStatusOrder $e");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future getOrderPending(int userId) async{
    _isLoading=true;
    notifyListeners();
    try{
      final result= await orderHttp().getOrderByStatus("pending",userId);
      if(result!=null){
        _pending=result;
      }
    }catch(e){
      throw Exception("Provider - khong the getOrderPending $e");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future getOrderPaying(int userId) async{
    _isLoading=true;
    notifyListeners();
    try{
      final result= await orderHttp().getOrderByStatus("paying",userId);
      if(result!=null){
        _paying=result;
      }
    }catch(e){
      throw Exception("Provider - khong the getOrderPaying $e");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future getOrderDelivering(int userId) async{
    _isLoading=true;
    notifyListeners();
    try{
      final result= await orderHttp().getOrderByStatus("delivering",userId);
      if(result!=null){
        _delivering=result;
      }
    }catch(e){
      throw Exception("Provider - khong the getOrderDelivering $e");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future getOrderSuccess(int userId) async{
    _isLoading=true;
    notifyListeners();
    try{
      final result= await orderHttp().getOrderByStatus("success",userId);
      if(result!=null){
        _success=result;
      }
    }catch(e){
      throw Exception("Provider - khong the getOrderSuccess $e");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future getOrderReturned(int userId) async{
    _isLoading=true;
    notifyListeners();
    try{
      final result= await orderHttp().getOrderByStatus("returned",userId);
      if(result!=null){
        _returned=result;
      }
    }catch(e){
      throw Exception("Provider - khong the getOrderReturned $e");
    }finally{
      _isLoading=false;
      notifyListeners();
    }
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

  void clearPreviewOrder(){
    _previewOrder=new PreviewOrder(total_cost: 0, discount: 0, grand_total: 0);
  }

  void addListIdProduct(int id){
    if(!_listproductid.contains(id)){
      _listproductid.add(id);
    }
    notifyListeners();
  }

  void clearListIdProduct(){
    _listproductid.clear();
    notifyListeners();
  }
}