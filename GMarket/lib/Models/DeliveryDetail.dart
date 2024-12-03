

class DeliveryDetail {
  final int? ID;
  final String? deliveryName;
  final String? shipCode;
  final String? description;
  final int? weight;
  final String? deliveryAddress;
  final String? deliveryContact;
  final int? deliveryFee;
  final int? deliveryId;

  DeliveryDetail({
    required this.ID,
    required this.deliveryName,
    required this.shipCode,
    required this.description,
    required this.weight,
    required this.deliveryAddress,
    required this.deliveryContact,
    required this.deliveryFee,
    required this.deliveryId,
  });

  factory DeliveryDetail.fromJson(Map<String, dynamic> json) {
    return DeliveryDetail(
      ID: json['ID'],
      deliveryName: json['deliveryname'],
      shipCode: json['shipcode'],
      description: json['description'],
      weight: json['weight'],
      deliveryAddress: json['deliveryaddress'],
      deliveryContact: json['deliverycontact'],
      deliveryFee: json['deliveryfee'],
      deliveryId: json['delivery_id'],
    );
  }
}