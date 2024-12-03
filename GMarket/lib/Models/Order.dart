

import 'package:gmarket/Models/OrderDetail.dart';
import 'package:gmarket/Models/User.dart';

class Order{
  final int ID;
  final int user_id;
  final int cart_id;
  final int grandtotal;
  final String status;
  final List<OrderDetail> order_details;
  final Users User;


  Order({
    required this.ID,
    required this.user_id,
    required this.cart_id,
    required this.grandtotal,
    required this.status,
    required this.order_details,
    required this.User
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      ID: json['ID'],
      user_id: json['user_id'],
      cart_id: json['cart_id'],
      grandtotal: json['grandtotal'],
      status: json['status'],
      order_details: json['order_details'] != null ? (json['order_details'] as List<dynamic>).map((orderDetail) => OrderDetail.fromJson(orderDetail)).toList() : [],
      User: Users.fromJson(json['User'])
    );
  }
}