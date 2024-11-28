
import 'package:gmarket/Models/DeliveryDetail.dart';


class Delivery {
  final int? ID;
  final String? status;
  final int? orderId;
  final int? userId;
  final List<DeliveryDetail>? details;

  Delivery({
    required this.ID,
    required this.status,
    required this.orderId,
    required this.userId,
    required this.details,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      ID: json['ID'] as int?,
      status: json['status'] as String?,
      orderId: json['orderId'] as int?,
      userId: json['userId'] as int?,
      details: json['details'] != null ? (json['details'] as List<dynamic>) .map((detailJson) => DeliveryDetail.fromJson(detailJson)).toList() : null,
    );
  }
}
