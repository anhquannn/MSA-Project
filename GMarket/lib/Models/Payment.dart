
class Payment{
  final int ID;
  final String paymentmethod;
  final String status;
  final int grandtotal;
  final int user_id;
  final int order_id;

  Payment({
    required this.ID,
    required this.paymentmethod,
    required this.status,
    required this.grandtotal,
    required this.order_id,
    required this.user_id,
  });
  factory Payment.fromJson(Map<String,dynamic> json){
    return Payment(
      ID: json['ID'],
      user_id: json['user_id'],
      paymentmethod: json['paymentmethod'],
      status: json['status'],
      grandtotal: json['grandtotal'],
      order_id: json['order_id'],
    );
  }

}