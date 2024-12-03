

import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Order_List.dart';
import 'package:gmarket/Screens/AdminScreen/Order_Search.dart';
import 'package:provider/provider.dart';

void main(){
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: Widget_Order(),
    )
  );
}

class Widget_Order extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_Order_Sate();
  }
}

class Widget_Order_Sate extends State<Widget_Order>{
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final orderProvider=Provider.of<Order_Provider>(context);
    final userProvider=Provider.of<User_Provider>(context);
    return  Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: Center(
          child:Container(
              width: width*0.9,
            child: SingleChildScrollView(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: width*0.03,),
                    //Tìm kiếm đơn hàng
                    ElevatedButton(
                      onPressed: () {
                        orderProvider.clearOrders();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Order_Search(),));},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
                        fixedSize: Size(width * 0.4, width * 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.grey[300],
                        elevation: 7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Color.fromRGBO(94, 200, 248, 1),
                            size: width * 0.2,
                          ),
                          const Center(
                            child: Text(
                              "Tìm kiếm đơn hàng",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Coiny-Regular-font',
                                color: Colors.black,
                              ),textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: width*0.04,),
                    //xem don hang
                    ElevatedButton(
                      onPressed: () async{
                        loading();
                        await orderProvider.getAllOrder();
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Order_List(),)
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
                        fixedSize: Size(width * 0.4, width * 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.grey[300],
                        elevation: 7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            color: Color.fromRGBO(94, 200, 248, 1),
                            size: width * 0.2,
                          ),
                          const Center(
                            child: Text(
                              "Xem đơn hàng",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Coiny-Regular-font',
                                color: Colors.black,
                              ),textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
                )
            ),
          )
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