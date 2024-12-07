import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/CartItem.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:provider/provider.dart';

class CartItem_Item extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CartItem_Item_State();
  }

  String? image;
  String? name;
  int? price;
  int? product_id;
  int? cart_id;
  int quantity;
  int? cartItemId;
  CartItem_Item({
    required this.image,
    required this.name,
    required this.price,
    required this.product_id,
    required this.cart_id,
    required this.cartItemId,
    required this.quantity,
});
}
class CartItem_Item_State extends State<CartItem_Item>{

  void increase() {
    setState(() {
      widget.quantity++;
    });
    print("Tang quantity ${widget.quantity} productid: ${widget.product_id}");
    Provider.of<CartItem_Provider>(context,listen: false).updateCartItem(
        new CartItem(
            ID: widget.cartItemId, status: "status", price: 999, quantity: widget.quantity, cart_id: widget.cart_id, product_id: widget.product_id
        ));
  }


  void decrease() {
    if (widget.quantity > 1) {
      setState(() {
        widget.quantity--;
      });
      print("Giam quantity ${widget.quantity} productid: ${widget.product_id}");
      Provider.of<CartItem_Provider>(context,listen: false).updateCartItem(
        new CartItem(
            ID: widget.cartItemId, status: "status", price: 999, quantity: widget.quantity, cart_id: widget.cart_id, product_id: widget.product_id
        ));
    }
  }

  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    final itemCartItem=Provider.of<CartItem_Provider>(context,listen: false);
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
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 244, 244, 1),
                    border: Border.all(width: 0.5, color: Colors.black),
                  ),
                  // height: height * 0.2,
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
                            Row(
                              children: [
                                // Nút giảm số lượng
                                ElevatedButton(
                                  onPressed: decrease,
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
                                //quantity
                                Text(
                                  "${widget.quantity}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 10),
                                // Nút tăng số lượng
                                ElevatedButton(
                                  onPressed: increase,
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
                                  child: Text("+"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked=value!;
                              });
                              int? id=widget.cartItemId;
                              if (isChecked) {
                                itemCartItem.addIdToList(id!);
                              } else {
                                itemCartItem.removeIdFromList(id!);
                              }
                            },
                        ),
                      )
                    ],
                  ),
                )
              ],
            )

        )
      );
  }

}