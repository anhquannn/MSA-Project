
class Cart{
  final String status;
  final int user_id;
  final int ID;
  // final List<CartItem> items;

  Cart({
    required this.status,
    required this.user_id,
    required this.ID,
    // required this.items,
  });
  factory Cart.fromJson(Map<String,dynamic> json){
    return Cart(
        status: json['status'],
        user_id: json['user_id'],
        ID: json['ID'],
      // items:(json['items'] as List).map((item) => CartItem.fromJson(item)).toList(),
    );
  }
}