import 'dart:convert';

import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/CartItem.dart';
import 'package:http/http.dart' as http;
class cartItemHttp{
  // String baseUrl='http://172.22.14.98:8080';
  String baseUrl='http://192.168.1.6:8080';

  Future<CartItem?> addProductToCart(CartItem c) async{
    final url=Uri.parse('$baseUrl/cartitems/addproduct/${c.cart_id}');
    final token=await userHTTP().GetToken();
    print('$url');
    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'product_id':c.product_id,
            'quantity':c.quantity,
          })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final cartItem=CartItem.fromJson(data);
        return cartItem;
      }
    }catch(e){
      Exception("Không thể thêm sản phẩm vào item giỏ hàng $e");
    }
    return null;
  }

  Future<bool?> updateCartItem(CartItem c) async{
    final url=Uri.parse('$baseUrl/cartitems/${c.ID}');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.put(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode( {
            'product_id':c.product_id,
            'cart_id':c.cart_id,
            'quantity':c.quantity,
            'status':c.status
          })
      );
      print('$url --product_id: ${c.product_id} --cart_id: ${c.cart_id} --quantity: ${c.quantity}');
      if(response.statusCode==200){
        return true;
      }
      else{
        return false;
      }
    }catch(e){
      Exception("Không thể sửa item giỏ hàng $e");
    }
    return false;
  }

  Future<bool?> deleteCartItem(int id) async{
    final url=Uri.parse('$baseUrl/cartitems/$id');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.delete(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
      );
      if(response.statusCode==200){
        return true;
      }
      else{
        return false;
      }
    }catch(e){
      Exception("Http - Không thể xóa item giỏ hàng $e");
    }
    return false;
  }

  Future<CartItem?> getCartItemByID(int id) async{
    final url=Uri.parse('$baseUrl/cartitems/$id');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.get(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final cart=CartItem.fromJson(data);
        return cart;
      }
      else{
        return null;
      }
    }catch(e){
      Exception("Không thể lấy giỏ hàng id $id : $e");
    }
    return null;
  }

  Future<bool?> clearCart(int id) async{
    final url=Uri.parse('$baseUrl/cartitem/clearcart');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.post(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body: json.encode({
          'cartID': id
        }),
      );
      if(response.statusCode==200){
        return true;
      }
      else{
        return false;
      }
    }catch(e){
      Exception("Không thể xóa giỏ hàng id $id : $e");
    }
    return false;
  }

  Future<List<CartItem>?> getCartItemsByCartID(int cartId) async{
    final url=Uri.parse('$baseUrl/cartitems/carts/${cartId}');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.get(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
      );
      if(response.statusCode==200){
        final List<dynamic> data = jsonDecode(response.body);
        final List<CartItem> cart = (data as List<dynamic>).map((item) => CartItem.fromJson(item)).toList();
        print('http ${cart[0].price}');
        return cart;
      }
      else{
        return null;
      }
    }catch(e){
      Exception("Không thể lấy giỏ hàng cartId $cartId : $e");
    }
    return null;
  }

  Future<bool?> updateCartItemsStatus(List<int> listCartItem, String status) async{
    final url=Uri.parse('$baseUrl/cartitems/');
    final token=await userHTTP().GetToken();
    print("status http $status");
    try{
      final response=await http.put(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body: jsonEncode({
        "cart_item_ids": listCartItem,
        "status":status
        }
        ));
      if(response.statusCode==200){
        return true;
      }
    }catch(e){
      Exception("Không thể updateCartItemsStatus : $e");
    }
    return false;
  }

  Future<List<CartItem>?> getAllCartItemsByCartID(int cartId) async{
    final url=Uri.parse('$baseUrl/cartitems/carts/all/$cartId');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.get(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
      );
      if(response.statusCode==200){
        final List<dynamic> data = jsonDecode(response.body);
        final List<CartItem> cart = data.map((item) => CartItem.fromJson(item)).toList();
        print('getAllCartItemsByCartID ${cart[0].price}');
        return cart;
      }
      else{
        return null;
      }
    }catch(e){
      Exception("Không thể lấy giỏ hàng cartId $cartId : $e");
    }
    return null;
  }
}