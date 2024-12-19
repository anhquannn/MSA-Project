
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widget_Order_History extends StatelessWidget {
  final int ID;
  final int grandtotal;
  final String status;

  final VoidCallback onTap;

  Widget_Order_History({
    required this.ID,
    required this.grandtotal,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: onTap,
        child:Container(
          width: width*0.95,
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Color.fromRGBO(94, 200, 248, 1),
                width: 1.5,
                style: BorderStyle.solid),
          ),
          child: Container(
            child: Row(
              children: [
                Container(
                  width: width*0.25,
                  height: height*0.12,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(94, 200, 248, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.card_giftcard),
                ),
                SizedBox(width: width*0.03,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ID đơn hàng
                    Text(
                      "ID đơn hàng: $ID",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    // Tổng số tiền
                    Text(
                      "Tổng số tiền: $grandtotal",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    // Trạng thái đơn hàng
                    Text(
                      "Trạng thái đơn hàng: $status",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                  ],
                ),
              ],
            ),


          ),
        )
    );
  }


}
