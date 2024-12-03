
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/RetrunOrder.dart';
import 'package:gmarket/Screens/AdminScreen/Order_History.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Order_List extends StatefulWidget{
  @override
  State createState() {
    return Order_List_State();
  }
}
class Order_List_State extends State<Order_List> {
int page=1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final orderProvider=Provider.of<Order_Provider>(context);
    final returnOrderProvider=Provider.of<ReturnOrder_Provider>(context,listen: false);

    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          title: const Text("Quản lý đơn hàng",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Coiny-Regular-font',
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: width*0.95,
            child: SingleChildScrollView(
              child:
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderProvider.orders.length,
                    itemBuilder: (context, index) {
                      final cat = orderProvider.orders[index];
                      return WidgetOrderItem(
                        ID:cat.ID,
                        grandtotal: cat.grandtotal,
                        status: cat.status,
                        address: cat.User.address,
                        email: cat.User.email,
                        name: cat.User.fullname,
                        phoneNumber: cat.User.phonenumber,
                        onTap: () async{
                          final product= orderProvider.orders[index];
                          returnOrderProvider.setorderid(cat.ID);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Order_History(id: index),)
                          );
                        },

                      );
                    },
                  ),
                  //Xem thêm.
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
                        setState(() {
                          page++;
                        });
                        await orderProvider.fillOrder(page);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Xem thêm...",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Coiny-Regular-font'),
                      )),
                ],
              ),
            ),
          )
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

  void loading(){
  showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  },);
}

}
