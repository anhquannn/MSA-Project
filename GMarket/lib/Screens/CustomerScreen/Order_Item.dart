
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:provider/provider.dart';

class Order_Info extends StatefulWidget {
  @override
  State createState() {
    return Order_Info_State();
  }
}

class Order_Info_State extends State<Order_Info> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Đơn hàng của bạn",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Coiny-Regular-font',
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      
      body: Consumer3<Order_Provider, User_Provider, CartItem_Provider>(
        builder: (context, orderProvider, userProvider, cartProvider, child) {
          if (orderProvider.isLoading ) {
            return const Center(child: CircularProgressIndicator());
          }
          if (orderProvider.orders.isEmpty || userProvider.user == null ) {
            // print(cartProvider.cart!.cart_id);
            return Center(child: Text("Không có dữ liệu để hiển thị"));
          }
          return ListView.builder(
            itemCount: orderProvider.orders.length,
            itemBuilder: (context, index) {
              final order = orderProvider.orders[index];
              final user = userProvider.user;
              final cart= cartProvider.cart;
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        width: 1.5,
                        style: BorderStyle.solid),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ID đơn hàng
                      Text(
                        "ID đơn hàng: ${order.ID.toString()}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Tổng số tiền
                      Text(
                        "Tổng số tiền: ${order.grandtotal.toString()}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Trạng thái đơn hàng
                      Text(
                        "Trạng thái đơn hàng: ${order.status ?? 'N/A'}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Tên khách hàng
                      Text(
                        "Tên khách hàng: ${user?.fullname ?? 'N/A'}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Email khách hàng
                      Text(
                        "Email khách hàng: ${user?.email ?? 'N/A'}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Số điện thoại khách hàng
                      Text(
                        "Số điện thoại khách hàng: ${user?.phonenumber ?? 'N/A'}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Địa chỉ khách hàng
                      Text(
                        "Địa chỉ khách hàng: ${user?.address ?? 'N/A'}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

