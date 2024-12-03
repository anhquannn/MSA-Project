import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/RetrunOrder.dart';
import 'package:gmarket/Screens/CustomerScreen/Order_Paying.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_History.dart';
import 'package:provider/provider.dart';

class Widget_Order_Paying extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_Order_Paying_State();
  }

}
class Widget_Order_Paying_State extends State<Widget_Order_Paying>{
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final returnOrderProvider=Provider.of<ReturnOrder_Provider>(context);
    final orderProvider=Provider.of<Order_Provider>(context);
    return Container(
      width: width*0.95,
      child: SingleChildScrollView(
        child: Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: orderProvider.paying.length,
            itemBuilder: (context, index) {
              final od=orderProvider.paying[index];
              return Container(
                child: Widget_Order_History(
                  ID: od.ID,
                  grandtotal: od.grandtotal,
                  status: od.status,
                  onTap: () {
                    returnOrderProvider.setorderid(od.ID);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Order_Paying(
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