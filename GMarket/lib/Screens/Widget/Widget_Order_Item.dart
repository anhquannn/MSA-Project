import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetOrderItem extends StatelessWidget {
  final int ID;
  final int grandtotal;
  final String status;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final VoidCallback onTap;

  WidgetOrderItem({
    required this.ID,
    required this.grandtotal,
    required this.status,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
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
          height: height*0.15,
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Color.fromRGBO(94, 200, 248, 1),
                width: 1,
                style: BorderStyle.solid),
          ),
          child: Container(
              child:Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    height: height*0.145,
                    child: Icon(Icons.assignment, color: Colors.white,size: height*0.13,),
                  ),
                  SizedBox(width: width*0.01,),
                  Container(
                    width: width*0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ID đơn hàng
                        Text(
                          "ID đơn hàng: $ID",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        // Tổng số tiền
                        Text(
                          "Tổng số tiền: $grandtotal",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        // Trạng thái đơn hàng
                        Text(
                          "Trạng thái đơn hàng: $status",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        // Tên khách hàng
                        Text(
                          "Tên khách hàng: $name",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Số điện thoại khách hàng
                        Text(
                          "Số điện thoại khách hàng: $phoneNumber",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );
  }


}
