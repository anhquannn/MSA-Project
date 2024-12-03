

import 'package:gmarket/Models/Product.dart';
class OrderDetail{
  final String status;
  final int quantity;
  final int unitprice;
  final int totalprice;
  final int product_id;
  final int order_id;
  final int ID;
  final Product product;


  OrderDetail({
    required this.ID,
    required this.status,
    required this.quantity,
    required this.unitprice,
    required this.totalprice,
    required this.product_id,
    required this.order_id,
    required this.product,
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
      product: Product.fromJson( json['Product'])
    );
  }

}