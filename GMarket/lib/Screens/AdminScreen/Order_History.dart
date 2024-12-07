import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Admin_Screen.dart';
import 'package:gmarket/Screens/AdminScreen/Order_List.dart';
import 'package:provider/provider.dart';

class Order_History extends StatefulWidget {
  int id=0;
  Order_History({
    required this.id
  });
  @override
  State<StatefulWidget> createState() {
    return Order_History_State();
  }
}
class Order_History_State extends State<Order_History> {
  List<int> product_id=[];
  int order_Id=0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final orderProvider=Provider.of<Order_Provider>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(94, 200, 248, 1),
        leading: IconButton(
          onPressed: () async {
            orderProvider.clearListIdProduct();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Đặt hàng",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Coiny-Regular-font',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: height * 0.01),
                //Thong tin don hang
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      width: 1,
                      color: Color.fromRGBO(94, 200, 248, 1),
                    ),
                  ),
                  width: width * 0.95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.01),
                      //Tên người dùng
                      Text(
                        "Tên người dùng: ${orderProvider.orders[widget.id].User.fullname}",
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      //Địa chỉ
                      Text(
                        "Địa chỉ:  ${orderProvider.orders[widget.id].User.address}",
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      //Số điện thoại
                      Text(
                        "Số điện thoại:  ${orderProvider.orders[widget.id].User.phonenumber}",
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                //danh sach san pham
                SizedBox(height: height*0.01,),
                Container(
                  width: width*0.95,
                  // height: height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderProvider.orders[widget.id].order_details.length,
                    itemBuilder: (context, index) {

                      final product= orderProvider.orders[widget.id].order_details[index].product;
                      final quantity= orderProvider.orders[widget.id].order_details[index].quantity;

                      for(int i=0;i<orderProvider.orders[widget.id].order_details.length;i++){
                        orderProvider.addListIdProduct(product.ID!);
                      }
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(4),
                        width: width,
                        height: height*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color.fromRGBO(94, 200, 248, 1)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //hinh anh
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              width: width * 0.3,
                              height: height * 0.3,
                              child: Image.memory(
                                base64Decode(product.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            //thong tin
                            Container(
                              width: width * 0.5,
                              height: height*0.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //name
                                  Text(
                                    product.name!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    softWrap: true,
                                  ),
                                  SizedBox(height: height * 0.06),
                                  //price
                                  Text(
                                    '${product.price!} VND',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  //quantity
                                  Text(
                                    "Số lượng: ${quantity}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                //Xóa đơn hàng
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
                      loading();
                      await orderProvider.deleteOrder(orderProvider.orders[widget.id].ID);
                      Navigator.pop(context);
                      // Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => AdminScreen(),),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      "Xóa đơn hàng",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Coiny-Regular-font'),
                    )),
                SizedBox(height: height*0.5,)

              ],
            ),
          ),
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
