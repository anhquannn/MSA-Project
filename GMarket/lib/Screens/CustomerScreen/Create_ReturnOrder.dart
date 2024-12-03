
import 'package:flutter/material.dart';
import 'package:gmarket/Models/ReturnOrder.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/RetrunOrder.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/CustomerScreen/Order_List.dart';
import 'package:provider/provider.dart';

class Create_ReturnOrder extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return Create_ReturnOrder_State();
  }
}
class Create_ReturnOrder_State extends State<Create_ReturnOrder> {
  String reason="";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final returnOrderProvider=Provider.of<ReturnOrder_Provider>(context,listen: false);
    final userProvider=Provider.of<User_Provider>(context);
    final orderProvider=Provider.of<Order_Provider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Trả hàng",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Coiny-Regular-font',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            color: Colors.white,
            width: width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.01,),
                  //Ly do
                  TextField(
                    minLines: 1,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Lý do trả hàng",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Coiny-Regular-font'
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(94, 200, 248, 1),
                            width: 2,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(94, 200, 248, 1),
                            width: 1,
                          )
                      ),
                    ),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ),
                    onChanged: (value) {
                      setState(() {
                        reason = value;
                      });
                    },
                  ),
                  SizedBox(height: height * 0.01,),
                  //Tao tra hang
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
                        if(reason==""){
                          showMessage(context, "Vui lòng nhập lí do trả hàng");
                        }
                        else{
                          await returnOrderProvider.createReturnOrder(
                              new ReturnOrder(
                                  id: 0,
                                  status: "status",
                                  reason: reason,
                                  refundAmount: 1,
                                  orderId: returnOrderProvider.orderid!
                              )
                          );
                          loading();
                          await orderProvider.getOrderPending(userProvider.user!.ID);
                          await orderProvider.getOrderPaying(userProvider.user!.ID);
                          await orderProvider.getOrderDelivering(userProvider.user!.ID);
                          await orderProvider.getOrderSuccess(userProvider.user!.ID);
                          await orderProvider.getOrderReturned(userProvider.user!.ID);
                          Navigator.pop(context);
                          returnOrderProvider.clearorderid();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Order_Info(),),
                                (Route<dynamic> route) => false,);
                        }
                      },
                      child: const Text("Trả hàng",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Coiny-Regular-font',
                        ),
                      )
                  ),
                  SizedBox(height: height * 0.01,),

                ],
              ),
            )
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
