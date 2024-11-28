
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Order_Delete.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: Order_List(),
      )));
}

class Order_List extends StatefulWidget{
  @override
  State createState() {
    return Order_List_State();
  }
}
class Order_List_State extends State<Order_List> {


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final orderProvider=Provider.of<Order_Provider>(context);
    final userProvider=Provider.of<User_Provider>(context);
    final cartItemProvider=Provider.of<CartItem_Provider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          title: const Text("Quản Lý Cửa Hàng",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Coiny-Regular-font',
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2
                  ),
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (context, index) {
                    final cat = orderProvider.orders[index];
                    return WidgetOrderItem(
                      ID:cat.ID,
                      grandtotal: cat.grandtotal,
                      status: cat.status,
                      onTap: () {
                        orderProvider.getOrderById(cat.ID).then((_){
                          userProvider.getUserById(orderProvider.order!.user_id);
                          cartItemProvider.getCartItemsByCartID(orderProvider.order!.cart_id);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Order_Delete(),)
                          );
                        });
                      },

                    );
                  },
                )

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
}
