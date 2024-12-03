
class CartItem{
  final int? ID;
  final String? status;
  final int? price;
  late  int? quantity;
  final int? cart_id;
  final int? product_id;


  CartItem({
    required this.ID,
    required this.status,
    required this.price,
    required this.quantity,
    required this.cart_id,
    required this.product_id,
  });

  factory CartItem.fromJson(Map<String,dynamic> json){
    return CartItem(
        ID: json['ID'],
        status: json['status'],
        price: json['price'],
        quantity: json['quantity'],
        cart_id: json['cart_id'],
        product_id: json['product_id']
    );
  }

}