
class ReturnOrder {
  int id;
  String status;
  String reason;
  int refundAmount;
  int orderId;

  ReturnOrder({
    required this.id,
    required this.status,
    required this.reason,
    required this.refundAmount,
    required this.orderId,
  });
  factory ReturnOrder.fromJson(Map<String, dynamic> json) {
    return ReturnOrder(
      id: json['id'] as int,
      status: json['status'],
      reason: json['reason'],
      refundAmount: json['refundAmount'],
      orderId: json['orderId'],
    );
  }

}