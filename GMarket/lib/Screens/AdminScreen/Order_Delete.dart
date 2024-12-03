
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:provider/provider.dart';

class Order_Delete extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Order_Delete_State();
  }

}

class Order_Delete_State extends State<Order_Delete>{
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    final orderProvider=Provider.of<Order_Provider>(context);
    final userProvider=Provider.of<User_Provider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        title: Text("Thông tin đơn hàng"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Coiny-Regular-font',
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body:Center(
        child: Container(
          color: Colors.white,
          // child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.01,),
              Container(
                  width: width*0.9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 1, style: BorderStyle.solid)
                  ),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Đảm bảo thông tin căn về phía bên trái
                    children: [
                      //ID đơn hàng
                      Text(
                        "ID đơn hàng: ${orderProvider.order?.ID.toString()}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Tổng số tiền
                      Text(
                        "Tổng số tiền: ${orderProvider.order?.grandtotal.toString()}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Tên khách hàng
                      Text(
                        "Tên khách hàng: ${userProvider.user!.fullname}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Email khách hàng
                      Text(
                        "Email khách hàng: ${userProvider.user!.email}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Số điện thoại khách hàng
                      Text(
                        "Số điện thoại khách hàng: ${userProvider.user!.phonenumber}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      // Địa chỉ khách hàng
                      Text(
                        "Địa chỉ khách hàng: ${userProvider.user!.address}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                    ],
                  )
              ),
              //button xoa
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
                  onPressed: () {
                    orderProvider.deleteOrder(orderProvider.order!.ID).then((_){
                      if(orderProvider.isLoading==false){
                        Navigator.pop(context);
                        showMessage(context, "Xóa thành công");
                      }

                    });
                  },
                  child: const Text(
                    "Xóa đơn hàng",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Coiny-Regular-font'),
                  )),
            ],
          ),
          // )
        ),
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