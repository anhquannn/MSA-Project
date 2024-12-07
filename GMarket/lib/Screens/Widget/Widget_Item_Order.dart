import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widget_Item_Order extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_Item_Order_State();
  }

  String? image;
  String? name;
  int? price;
  int? product_id;
  int? cart_id;
  int quantity;
  int? cartItemId;
  Widget_Item_Order({
    required this.image,
    required this.name,
    required this.price,
    required this.product_id,
    required this.cart_id,
    required this.cartItemId,
    required this.quantity,
  });
}
class Widget_Item_Order_State extends State<Widget_Item_Order>{

  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return
      Scaffold(
          backgroundColor: Colors.white,
          body:
          Center(
              child: Column(
                children: [
                  // SizedBox(height: height*0.01,),
                  Container(
                    width: width * 0.95,
                    height: height*0.2,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(244, 244, 244, 1),
                      // border: Border.all(width: 0.5, color: Colors.black),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //hinh anh
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: width * 0.35,
                          height: height * 0.3,
                          child: Image.memory(
                            base64Decode(widget.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        //thong tin
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //name
                              Text(
                                widget.name!,
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
                                '${widget.price! * widget.quantity} VND',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              //quantity
                              Text(
                                "Số lượng: ${widget.quantity}",
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
                  )
                ],
              )

          )
      );
  }

}