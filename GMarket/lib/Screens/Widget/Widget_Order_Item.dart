
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetOrderItem extends StatelessWidget {
  final int ID;
  final int grandtotal;
  final String status;
  final VoidCallback onTap;

  WidgetOrderItem({
    required this.ID,
    required this.grandtotal,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: Color.fromRGBO(244, 244, 244, 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child:Container(
            child: Center(
              child: Column(
                children: [
                  //ID đơn hàng
                  Text("ID đơn hàng: ${ID.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(width: 2,),
                  //Giá
                  Text("Giá trị: ${grandtotal.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(width: 2,),
                  //Trạng thái
                  Text("Trạng thái: ${status.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,),
                ],
              ),
            ),
          )
      ),
    );
  }


}
