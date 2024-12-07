
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/RetrunOrder.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Order_History.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_Item.dart';
import 'package:provider/provider.dart';

class Order_Search extends StatefulWidget {
  @override
  State createState() {
    return Order_Search_State();
  }
}

class Order_Search_State extends State<Order_Search> {
  @override
  Widget build(BuildContext context) {
    
    final orderProvider=Provider.of<Order_Provider>(context,listen: false);
    final userProvider=Provider.of<User_Provider>(context,listen: false);
    final returnOrderProvider=Provider.of<ReturnOrder_Provider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          keyboardType: TextInputType.number,
          onSubmitted: (value) async {
            await orderProvider.searchOrderByNumberPhone(value);
            for (var order in Provider.of<Order_Provider>(context, listen: false).orders) {
              await userProvider.getUserById(order.user_id);
            }
          },
          decoration: InputDecoration(
            hintText: "Tìm kiếm",
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromRGBO(94, 200, 248, 1),
                width: 3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 4,
                color: Color.fromRGBO(94, 200, 248, 1),
              ),
            ),
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
        ),
      ),
      body: Consumer3<Order_Provider, User_Provider, CartItem_Provider>(
        builder: (context, orderProvider, userProvider, cartProvider, child) {
          if (orderProvider.orders.isEmpty || userProvider.difuser.isEmpty ) {
            return Center(child: Text("Không có dữ liệu để hiển thị"));
          }
          return ListView.builder(
            itemCount: orderProvider.orders.length,
            itemBuilder: (context, index) {
              final order = orderProvider.orders[index];
              final user = userProvider.user;
              return WidgetOrderItem(
                ID:order.ID,
                grandtotal: order.grandtotal,
                status: order.status,
                address: order.User.address,
                email: order.User.email,
                name: order.User.fullname,
                phoneNumber: order.User.phonenumber,
                onTap: () async{
                  returnOrderProvider.setorderid(order.ID);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Order_History(id: index),)
                  );
                },

              );

            },
          );
        },
      ),
    );
  }
}

