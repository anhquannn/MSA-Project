import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/RetrunOrder.dart';
import 'package:gmarket/Screens/CustomerScreen/Order_Delivering.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_History.dart';
import 'package:provider/provider.dart';

class Widget_Delivering extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_Delivering_State();
  }

}
class Widget_Delivering_State extends State<Widget_Delivering>{
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final returnOrderProvider=Provider.of<ReturnOrder_Provider>(context,listen: false);
    final orderProvider=Provider.of<Order_Provider>(context);
    return Container(
      width: width*0.95,
      child: SingleChildScrollView(
        child: Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: orderProvider.delivering.length,
            itemBuilder: (context, index) {
              final od=orderProvider.delivering[index];
              return Container(
                child: Widget_Order_History(
                  ID: od.ID,
                  grandtotal: od.grandtotal,
                  status: od.status,
                  onTap: () {
                    returnOrderProvider.setorderid(od.ID);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Order_Delivering(
                          idOrders: index,
                        ),)
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}