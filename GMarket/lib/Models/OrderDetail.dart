
import 'dart:ffi';
import 'package:flutter/cupertino.dart';

class OrderDetail{
  final String status;
  final int quantity;
  final Float unitprice;
  final Float totalprice;
  final int product_id;
  final int order_id;
  final int ID;

  OrderDetail({
    required this.ID,
    required this.status,
    required this.quantity,
    required this.unitprice,
    required this.totalprice,
    required this.product_id,
    required this.order_id,
  });
  factory OrderDetail.fromJson(Map<String,dynamic> json){
    return OrderDetail(
      ID: json['ID'],
      status: json['status'],
      quantity: json['quantity'],
      unitprice: json['unitprice'],
      totalprice: json['totalprice'],
      product_id: json['product_id'],
      order_id: json['order_id'],
    );
  }

}