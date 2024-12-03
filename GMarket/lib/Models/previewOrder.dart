class PreviewOrder{
  final int total_cost;
  final int discount;
  final int grand_total;

PreviewOrder({
   required  this.total_cost,
   required  this.discount,
   required  this.grand_total,
});

  factory PreviewOrder.fromJson(Map<String,dynamic> json){
    return PreviewOrder(
      total_cost: json['total_cost'],
      discount: json['discount'],
      grand_total: json['grand_total'],
    );
  }
}
