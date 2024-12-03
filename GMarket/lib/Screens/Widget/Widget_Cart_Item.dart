import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:provider/provider.dart';

class Widget_Cart_Item extends StatefulWidget {
  String image;
  int price;
  int quantity;
  String name;
  VoidCallback onTap;

  Widget_Cart_Item({
    required this.image,
    required this.price,
    required this.quantity,
    required this.name,
    required this.onTap
  });
  @override
  State<StatefulWidget> createState() {
    return Widget_Cart_Item_State();
  }
}
class Widget_Cart_Item_State extends State<Widget_Cart_Item> {

  Future<void> increase() async {
    setState(() {
      widget.quantity++;
    });
    Provider.of<CartItem_Provider>(context).setQuantity(widget.quantity);
  }

  Future<void> decrease() async {
    if(widget.quantity>1){
      setState(() {
        widget.quantity--;
      });
      Provider.of<CartItem_Provider>(context).setQuantity(widget.quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Container(
          width: width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.black),
          ),
          height: height * 0.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: width * 0.35,
                height: height*0.5,
                child: Image.memory(
                  base64Decode(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: width * 0.03),
              Container(
                width: width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Ten
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                      ),
                      softWrap: true,
                    ),
                    SizedBox(height: height * 0.05),
                    //gia
                    Text(
                      '${widget.price} VND',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    //so luong
                    Row(
                      children: [
                        //nut tang
                        ElevatedButton(
                          onPressed:  decrease,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            minimumSize: const Size(5, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Text("-"),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${widget.quantity}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        //nut giam
                        ElevatedButton(
                          onPressed: increase,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                            minimumSize: Size(5, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Text("+"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
