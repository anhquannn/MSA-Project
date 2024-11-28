

class Order{
  final int ID;
  final int user_id;
  final int cart_id;
  final int grandtotal;
  final String status;
  // final List<OrderDetail> order_details;
  // final List<Payment> payments;
  // final List<ReturnOrder> return_orders;
  // final List<FeedBack> feedbacks;
  // final List<Delivery> deliveries;


  Order({
    required this.ID,
    required this.user_id,
    required this.cart_id,
    required this.grandtotal,
    required this.status,
    // required this.order_details,
    // required this.payments,
    // required this.return_orders,
    // required this.feedbacks,
    // required this.deliveries,
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      ID: json['ID'],
      user_id: json['user_id'],
      cart_id: json['cart_id'],
      grandtotal:json['grandtotal'],
      status: json['status'],
    );
  }

  // order_details: (json['order_details'] as List<dynamic>).map((order_details) => OrderDetail.fromJson(order_details)).toList(),
  // payments: (json['payments'] as List<dynamic>).map((paymentJson) => Payment.fromJson(paymentJson)).toList(),
  // return_orders: (json['return_orders'] as List<dynamic>).map((returnOrderJson) => ReturnOrder.fromJson(returnOrderJson)).toList(),
  // feedbacks: (json['feedbacks'] as List<dynamic>).map((feedbackJson) => FeedBack.fromJson(feedbackJson)).toList(),
  // deliveries: (json['deliveries'] as List<dynamic>).map((deliveryJson) => Delivery.fromJson(deliveryJson)).toList(),
}