import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/CustomerScreen/CartItem_Item.dart';
import 'package:gmarket/Screens/CustomerScreen/Order_List_Item.dart';
import 'package:provider/provider.dart';

class List_Cart_Item extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return List_Cart_Item_State();
  }

}
class List_Cart_Item_State extends State<List_Cart_Item> {
  bool getAll = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final itemProduct = Provider.of<ProductProvider>(context, listen: false);
    final itemCartItem = Provider.of<CartItem_Provider>(context, listen: false);
    final itemCart = Provider.of<Cart_Provider>(context, listen: false);
    final promocodeProvider=Provider.of<Promocode_Provider>(context,listen: false);
    final orderProvider=Provider.of<Order_Provider>(context,listen: false);
    final userProvider=Provider.of<User_Provider>(context,listen:false);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        leading: IconButton(
          onPressed: () async {
            loading();
            itemProduct.clearProducts();
            await itemProduct.getAllProduct();
            Navigator.pop(context);
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: const Text(
          "Thông tin sản phẩm",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Coiny-Regular-font',
          ),
        ),
        centerTitle: true,
      ),
      body:  Center(
        child: itemCartItem.cartItems!.isEmpty
            ? Center(child: Text("Không có dữ liệu"))
            : ListView.builder(
          // shrinkWrap: true,
          itemCount: itemCartItem.cartItems!.length,
          itemBuilder: (context, index) {
            final product = itemProduct.products[index];
            final quantity = itemCartItem.cartItems?[index].quantity;
            final cartItemId = itemCartItem.cartItems?[index].ID;

            if (itemCartItem.cartItems!.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                width: width,
                height: height * 0.21,
                child: CartItem_Item(
                  image: product!.image,
                  name: product.name,
                  price: product.price,
                  product_id: product.ID,
                  cart_id: itemCart.cart!.ID,
                  quantity: quantity!,
                  cartItemId: cartItemId!,
                ),
              );
            }
          },
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(244, 244, 244, 1),
        child: Consumer<CartItem_Provider>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Đặt hàng
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(94, 200, 248, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                              color: Colors.black,
                              width: 0.2
                          )
                      )
                  ),
                  onPressed: () async {
                    /*
                    updateCatrItem thành available -> xóa cartItem
                    -> xóa danh sách product -> lấy promocode -> lấy cartItem available
                    -> lấy productById theo danh sách cartItem
                     */
                    if (itemCartItem.listid.isNotEmpty) {
                      await itemCartItem.updateCartItemStatus(itemCartItem.listid, "available");
                      // itemCartItem.clearListId();
                      itemProduct.clearProducts();
                      await promocodeProvider.getAllPromoCode();
                      await itemCartItem.getCartItemsByCartID(itemCart.cart!.ID);
                      for (int i = 0; i < itemCartItem.cartItems!.length; i++) {
                        await itemProduct.addProduct(itemCartItem.cartItems![i].product_id!);
                        print("${itemProduct.products[i]!.name}");
                      }
                      orderProvider.getPreviewOrder(userProvider.user!.ID, itemCart.cart!.ID, "");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Order_List_Item()),
                      );
                    } else {
                      showMessage(context, "Không có sản phẩm");
                    }
                  },
                  child: const Text(
                    "Đặt hàng",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Coiny-Regular-font',
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void loading(){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
  }
}